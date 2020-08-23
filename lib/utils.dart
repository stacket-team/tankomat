import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tankomat/constants.dart';
import 'package:firebase/firebase.dart' as firebase;
import 'package:firebase/firestore.dart' as firestore;

void initializeFirebase() {
  try {
    if (firebase.apps.isEmpty) {
      firebase.initializeApp(
        apiKey: API_KEY,
        authDomain: AUTH_DOMAIN,
        databaseURL: DATABASE_URL,
        storageBucket: STORAGE_BUCKET,
        projectId: PROJECT_ID,
        appId: APP_ID,
        messagingSenderId: MESSAGING_SENDER_ID,
        measurementId: MEASUREMENT_ID,
      );
    }
  } on firebase.FirebaseJsNotLoadedException catch (e) {
    print(e.toString());
  }
}

Auth initializeAuth(BuildContext context, Function onUserLogin) {
  firebase.Auth auth = firebase.auth();
  auth.useDeviceLanguage();
  auth.onAuthStateChanged.listen((firebase.User user) async {
    if (user != null) {
      if (user.emailVerified) {
        onUserLogin(user);
        Navigator.of(context).pushNamed('/');
      } else {
        Navigator.of(context).pushNamed('/verifyEmail');
      }
    } else {
      Navigator.of(context).pushNamed('/login');
    }
  });
  return Auth(auth);
}

class Auth {
  final firebase.Auth auth;

  Auth(this.auth);

  Future<void> sendEmailVerification() =>
      auth.currentUser.sendEmailVerification(
          firebase.ActionCodeSettings(url: 'https://$AUTH_DOMAIN'));

  Future<bool> confirmEmailVerified() async {
    await auth.currentUser.reload();
    return auth.currentUser.emailVerified;
  }

  Future<firebase.UserCredential> loginUser(String email, String password) =>
      auth.signInWithEmailAndPassword(email, password);

  Future<void> loginUserWithGoogle(BuildContext context) =>
      loginUserWithProvider(context, firebase.GoogleAuthProvider());

  Future<void> loginUserWithFacebook(BuildContext context) =>
      loginUserWithProvider(context, firebase.FacebookAuthProvider());

  Future<void> loginUserWithProvider(
      BuildContext context, firebase.AuthProvider provider) async {
    try {
      firebase.UserCredential userCredential =
          await auth.signInWithPopup(provider);
      if (userCredential.additionalUserInfo.isNewUser) {
        String name;
        if (provider is firebase.GoogleAuthProvider) {
          name = userCredential.additionalUserInfo.profile['given_name'];
        } else if (provider is firebase.FacebookAuthProvider) {
          name = 'FacebookName';
          print(userCredential.additionalUserInfo.username);
          print(userCredential.additionalUserInfo.profile);
        }
        await User.createUserData(
          userCredential.user.uid,
          name,
        );
      }
    } catch (e) {
      if (e.code == 'auth/account-exists-with-different-credential') {
        Map<dynamic, String> providersStrings = {
          firebase.GoogleAuthProvider: 'przez Google',
          firebase.FacebookAuthProvider: 'przez Facebook',
        };
        Navigator.of(context).pushNamed(
          '/linkCredentials',
          arguments: {
            'email': e.email,
            'credential': e.credential,
            'providerString': providersStrings[provider],
          },
        );
      } else {
        throw e;
      }
    }
  }

  Future<List<String>> getLoginMethods(String email) =>
      auth.fetchSignInMethodsForEmail(email);

  Future<void> linkCredentials(dynamic credential) =>
      credential is firebase.OAuthCredential
          ? auth.currentUser.linkWithCredential(credential)
          : auth.currentUser.updatePassword(credential['password']);

  Future<void> resetPassword(String email) =>
      auth.sendPasswordResetEmail(email);

  Future<void> unlinkGoogle() => unlinkProvider('google.com');

  Future<void> linkGoogle() =>
      auth.currentUser.linkWithPopup(firebase.GoogleAuthProvider());

  Future<void> unlinkFacebook() => unlinkProvider('facebook.com');

  Future<void> linkFacebook() =>
      auth.currentUser.linkWithPopup(firebase.FacebookAuthProvider());

  Future<void> unlinkPassword() => unlinkProvider('password');

  Future<void> unlinkProvider(String provider) =>
      auth.currentUser.unlink(provider);

  Future<void> createUser(String name, String email, String password) async {
    firebase.UserCredential userCredential =
        await auth.createUserWithEmailAndPassword(email, password);

    await User.createUserData(
      userCredential.user.uid,
      name,
    );

    await sendEmailVerification();
  }

  Future<void> logoutUser() => auth.signOut();
}

class User extends Events {
  final firebase.User user;
  final Auth auth;
  final String uid;
  bool isLoaded = false;
  firestore.DocumentReference ref;
  firestore.DocumentSnapshot snapshot;
  String name;
  String email;
  String photoURL;
  List<String> providers;

  User(this.user, this.auth) : uid = user.uid {
    load();
  }

  @override
  int onEvent(String name, Function callback) {
    if (isLoaded) callback(true);
    return super.onEvent(name, callback);
  }

  load() async {
    ref = firebase.firestore().collection('users').doc(uid);
    try {
      await loadAuth();
      await loadData();
    } catch (e) {
      print(e.toString());
    }
    isLoaded = true;
    emitEvent('load', false);
  }

  Future<void> loadAuth() async {
    email = user.email;
    photoURL = user.photoURL;
    providers = await auth.getLoginMethods(email);
  }

  Future<void> loadData() async {
    // TODO Auto reload data on snapshot listener
    snapshot = await ref.get();
    name = snapshot.get('name');
  }

  Future<void> reloadAuth() async {
    isLoaded = false;
    try {
      await user.reload();
      await loadAuth();
    } catch (e) {
      print(e.toString());
    }
    isLoaded = true;
    emitEvent('load', false);
  }

  Future<firestore.DocumentSnapshot> getUserData() => ref.get();

  static Future<void> createUserData(String uid, String name) {
    firestore.CollectionReference ref =
        firebase.firestore().collection('/users');

    Map<String, dynamic> userData = {
      'name': name,
      'draft': {
        'timestamp': firestore.FieldValue.serverTimestamp(),
        'name': '',
        'elements': [],
        'tags': [],
      },
      'trainings': [],
      'schedules': [],
      'following': [],
      'followers': [],
      'friends': [],
      'friendsRequests': [],
      'receiveFriendsRequests': true,
    };

    return ref.doc(uid).set(userData);
  }
}

class Events {
  final Map<String, Map<int, Function>> events = {};
  int lastID = 0;

  int onEvent(String name, Function callback) {
    lastID += 1;
    if (events.containsKey(name) == false) {
      events[name] = {};
    }
    events[name][lastID] = callback;
    return lastID;
  }

  void offEvent(String name, int id) {
    if (events.containsKey(name) && events[name].containsKey(id)) {
      events[name].remove(id);
    }
  }

  void emitEvent(String name, dynamic value) {
    if (events.containsKey(name)) {
      events[name].forEach((key, callback) {
        callback(value);
      });
    }
  }
}
