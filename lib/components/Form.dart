import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final List<Widget> children;
  const AuthForm({
    Key key,
    this.children,
  }) : super(key: key);

  @override
  _FormState createState() => _FormState(children: children);
}

class _FormState extends State<AuthForm> {
  // Create a global key that uniqley identifies the Form widget and allows validation of the form
  final _formKey = GlobalKey<_FormState>();
  final List<Widget> children;
  _FormState({this.children});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: children,
      ),
    );
  }
}
