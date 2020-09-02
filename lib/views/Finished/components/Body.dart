import 'package:flutter/material.dart';
import 'package:tankomat/components/Background.dart';

class Body extends StatelessWidget {
  final Function onSave;
  final Function onDiscard;

  Body({
    this.onSave,
    this.onDiscard,
  });

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Dobra robota!'),
            FlatButton(
              onPressed: onSave,
              child: Text('Zapisz trening'),
            ),
            FlatButton(
              onPressed: onDiscard,
              child: Text('Porzuć'),
            ),
          ],
        ),
      ),
    );
  }
}
