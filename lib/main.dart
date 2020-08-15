import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Tankomat",
        home: Scaffold(
          appBar: AppBar(
            title: AppBar(
              title: Text('Tankomat'),
            ),
          ),
          body: Center(child: Text('Hello World')),
        ));
  }
}
