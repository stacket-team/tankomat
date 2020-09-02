import 'package:flutter/material.dart';
import 'package:tankomat/constants.dart';

class DontHaveAnAccount extends StatelessWidget {
  final String text;
  final Function onPress;
  const DontHaveAnAccount({Key key, this.text, this.onPress}) : super(key: key);

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
