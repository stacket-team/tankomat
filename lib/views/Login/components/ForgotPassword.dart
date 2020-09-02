import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  final String text;
  final Function onPress;

  const ForgotPassword({
    Key key,
    this.text,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      width: size.width * 0.8,
      child: FlatButton(
        onPressed: onPress,
        child: Text(
          text,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
