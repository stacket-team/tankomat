import 'package:flutter/material.dart';
import 'package:tankomat/views/Home/HomeView.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
