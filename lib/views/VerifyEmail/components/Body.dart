import 'package:flutter/material.dart';
import 'package:tankomat/components/Button.dart';
import 'package:tankomat/components/Background.dart';

class Body extends StatelessWidget {
  final Function onSendValidationEmailPress;
  final Function onContinuePress;

  Body({
    this.onSendValidationEmailPress,
    this.onContinuePress,
  });

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Proszę, potwierdź swój adres e-mail, aby kontynuować',
              textAlign: TextAlign.center,
            ),
            Button(
              text: 'Kontynuuj',
              press: onContinuePress,
            ),
            Button(
              text: 'Wyślij ponownie',
              press: onSendValidationEmailPress,
            ),
          ],
        ),
      ),
    );
  }
}
