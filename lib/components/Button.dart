import 'package:flutter/material.dart';
import 'package:tankomat/constants.dart';

class Button extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const Button({
    Key key,
    this.text,
    this.press,
    this.color = PRIMARY_COLOR,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.6,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: RaisedButton(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          color: color,
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 15.0),
          ),
        ),
      ),
    );
  }
}
