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
  } on firebase.FirebaseJsNotLoadedException catch (e) {
    print(e.toString());
  }
}
