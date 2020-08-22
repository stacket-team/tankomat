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

void initializeAuth(BuildContext context) {
  firebase.Auth auth = firebase.auth();
  auth.useDeviceLanguage();
  auth.onAuthStateChanged.listen((firebase.User user) async {
    if (user != null) {
      if (user.emailVerified) {
        Navigator.of(context).pushNamed('/');
      } else {
        Navigator.of(context).pushNamed('/verifyEmail');
      }
    } else {
      Navigator.of(context).pushNamed('/login');
    }
  });
}

Future<void> sendEmailVerification() {
  firebase.Auth auth = firebase.auth();
  return auth.currentUser.sendEmailVerification(
      firebase.ActionCodeSettings(url: 'https://$AUTH_DOMAIN'));
}

Future<bool> confirmEmailVerified() async {
  firebase.Auth auth = firebase.auth();
  await auth.currentUser.reload();
  return auth.currentUser.emailVerified;
}

Future<firebase.UserCredential> loginUser(String email, String password) {
  firebase.Auth auth = firebase.auth();
  return auth.signInWithEmailAndPassword(email, password);
}

Future<void> loginUserWithGoogle(BuildContext context) {
  return loginUserWithProvider(context, firebase.GoogleAuthProvider());
}

Future<void> loginUserWithFacebook(BuildContext context) {
  return loginUserWithProvider(context, firebase.FacebookAuthProvider());
}

Future<void> loginUserWithProvider(
    BuildContext context, firebase.AuthProvider provider) async {
  firebase.Auth auth = firebase.auth();
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
      await createUserData(
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

Future<List<String>> getLoginMethods(String email) {
  firebase.Auth auth = firebase.auth();
  return auth.fetchSignInMethodsForEmail(email);
}

Future<void> linkCredentials(dynamic credential) {
  firebase.Auth auth = firebase.auth();
  return credential is firebase.OAuthCredential
      ? auth.currentUser.linkWithCredential(credential)
      : auth.currentUser.updatePassword(credential['password']);
}

Future<void> resetPassword(String email) {
  firebase.Auth auth = firebase.auth();
  return auth.sendPasswordResetEmail(email);
}

Future<void> unlinkGoogle() {
  return unlinkProvider('google.com');
}

Future<void> linkGoogle() {
  firebase.Auth auth = firebase.auth();
  return auth.currentUser.linkWithPopup(firebase.GoogleAuthProvider());
}

Future<void> unlinkFacebook() {
  return unlinkProvider('facebook.com');
}

Future<void> linkFacebook() {
  firebase.Auth auth = firebase.auth();
  return auth.currentUser.linkWithPopup(firebase.FacebookAuthProvider());
}

Future<void> unlinkPassword() {
  return unlinkProvider('password');
}

Future<void> unlinkProvider(String provider) {
  firebase.Auth auth = firebase.auth();
  return auth.currentUser.unlink(provider);
}

Future<firestore.DocumentSnapshot> getUserData(String uid) {
  firestore.CollectionReference ref = firebase.firestore().collection('/users');
  return ref.doc(uid).get();
}

Future<void> createUserData(String uid, String name) {
  firestore.CollectionReference ref = firebase.firestore().collection('/users');
  Map<String, dynamic> userData = {
    'name': name,
    'type': null,
    'history': [],
  };
  return ref.doc(uid).set(userData);
}

Future<void> createUser(String name, String email, String password) async {
  firebase.Auth auth = firebase.auth();

  firebase.UserCredential userCredential =
      await auth.createUserWithEmailAndPassword(email, password);

  await createUserData(userCredential.user.uid, name);

  await sendEmailVerification();
}

Future<void> logoutUser() {
  firebase.Auth auth = firebase.auth();
  return auth.signOut();
}
