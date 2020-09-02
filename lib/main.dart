import 'package:flutter/material.dart';
import 'package:tankomat/route_generator.dart';
import 'package:tankomat/theme.dart';
import 'package:tankomat/utils.dart';

void main() {
  initializeFirebase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Root widget of the application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tankomat',
      theme: theme(),
      initialRoute: '/loading',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
