import 'package:flutter/material.dart';
import 'package:tankomat/constants.dart';

class StartButton extends StatelessWidget {
  final String text;
  final Function onPress;

  StartButton(this.text, this.onPress);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: TAN,
      onPressed: onPress,
      child: Text(text),
    );
  }
}

class EndButton extends StatelessWidget {
  final String text;
  final Function onPress;

  EndButton(this.text, this.onPress);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: GREY,
      onPressed: onPress,
      child: Text(text),
    );
  }
}

class NavigationButton extends StatelessWidget {
  final String text;
  final Function onPress;

  NavigationButton(this.text, this.onPress);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPress,
      child: Text(text),
    );
  }
}
