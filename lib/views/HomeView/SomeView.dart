import 'package:flutter/material.dart';

class SomeView extends StatefulWidget {
  @override
  _SomeViewState createState() => _SomeViewState();
}

class _SomeViewState extends State<SomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('some view'),
      ),
    );
  }
}
