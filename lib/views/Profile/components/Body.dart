import 'package:flutter/material.dart';
import 'package:tankomat/components/Background.dart';
import 'package:tankomat/components/Button.dart';

class Body extends StatelessWidget {
  final Function onPress;

  Body({
    Key key,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Button(
              text: 'Wyloguj się',
              press: onPress,
            )
          ],
        ),
      ),
    );
  }
}
