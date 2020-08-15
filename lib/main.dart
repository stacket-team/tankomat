import 'package:flutter/material.dart';
import 'package:tankomat/views/Home/HomeView.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await DotEnv().load('.env');
  try {
    Map<String, String> config = DotEnv().env;
    fb.initializeApp(
        apiKey: config['API_KEY'],
        authDomain: config['AUTH_DOMAIN'],
        databaseURL: config['DATABASE_URL'],
        storageBucket: config['STORAGE_BUCKET'],
        projectId: config['PROJECT_ID'],
        appId: config['APP_ID'],
        messagingSenderId: config['MESSAGING_SENDER_ID'],
        measurementId: config['MEASUREMENT_ID']);

    runApp(MyApp());
  } on fb.FirebaseJsNotLoadedException catch (e) {
    print(e);
  }
}

class MyApp extends StatelessWidget {
  final fb.Auth auth;

  MyApp() : auth = fb.auth();

  // Root widget of the application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TANKOMAT',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(title: 'Login'),
    );
  }
}
