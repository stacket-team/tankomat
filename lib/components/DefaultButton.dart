import 'package:flutter/material.dart';
import 'package:tankomat/constants.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final Function onPress;

  const DefaultButton({
    Key key,
    this.text,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FlatButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: PRIMARY_COLOR,
        onPressed: onPress,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
