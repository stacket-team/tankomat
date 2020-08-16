import 'package:flutter/material.dart';
import 'package:tankomat/route_generator.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tankomat/utils.dart';

void main() async {
  await DotEnv().load('.env');
  initializeFirebase(DotEnv().env);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Root widget of the application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tankomat',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/login',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
