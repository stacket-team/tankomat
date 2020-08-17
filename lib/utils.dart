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

Future<void> loginUser(String email, String password) {
  firebase.Auth auth = firebase.auth();
  return auth.signInWithEmailAndPassword(email, password);
}

Future<void> createUser(String name, String email, String password) async {
  firebase.Auth auth = firebase.auth();
  firestore.CollectionReference ref = firebase.firestore().collection('/users');

  firebase.UserCredential userCredential =
      await auth.createUserWithEmailAndPassword(email, password);

  Map<String, dynamic> userData = {
    'name': name,
    'type': null,
    'history': [],
  };

  await ref.doc(userCredential.user.uid).set(userData);
}
