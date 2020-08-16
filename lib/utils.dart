import 'package:flutter/material.dart';
import 'package:tankomat/constants.dart';
import 'package:firebase/firebase.dart' as firebase;

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
        try {
          await auth.currentUser.sendEmailVerification(
              firebase.ActionCodeSettings(url: 'https://$AUTH_DOMAIN'));
        } catch (e) {
          // TODO Display information about email verification
          print(e.toString());
        }
      }
    } else {
      Navigator.of(context).pushNamed('/login');
    }
  });
}
