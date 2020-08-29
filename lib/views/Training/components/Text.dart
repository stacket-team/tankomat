import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final String text;

  BigText(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 22,
        ),
      ),
    );
  }
}

class SmallText extends StatelessWidget {
  final String text;

  SmallText(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Text(text),
    );
  }
}
