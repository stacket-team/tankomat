import 'package:firebase/firebase.dart' as firebase;

void initializeFirebase(Map<String, String> config) {
  try {
    if (firebase.apps.isEmpty) {
      firebase.initializeApp(
          apiKey: config['API_KEY'],
          authDomain: config['AUTH_DOMAIN'],
          databaseURL: config['DATABASE_URL'],
          storageBucket: config['STORAGE_BUCKET'],
          projectId: config['PROJECT_ID'],
          appId: config['APP_ID'],
          messagingSenderId: config['MESSAGING_SENDER_ID'],
          measurementId: config['MEASUREMENT_ID']);
    }
    firebase.Auth auth = firebase.auth();
    auth.useDeviceLanguage();
    auth.onAuthStateChanged
        .listen(authStateChanged(auth, config['AUTH_DOMAIN']));
  } on firebase.FirebaseJsNotLoadedException catch (e) {
    print(e.toString());
  }
}

Function authStateChanged(firebase.Auth auth, String authDomain) =>
    (firebase.User user) async {
      if (user != null) {
        if (user.emailVerified) {
          // TODO Redirect to Home instead of Register view
        } else {
          try {
            await auth.currentUser.sendEmailVerification(
                firebase.ActionCodeSettings(url: 'https://$authDomain'));
          } catch (e) {
            // TODO Display information about email verification
            print(e.toString());
          }
        }
      } else {
        // TODO Redirect user using router
      }
    };
