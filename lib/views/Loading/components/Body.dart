import 'package:flutter/material.dart';
import 'package:tankomat/components/Background.dart';
import 'package:tankomat/constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Background(
      backgroundColor: PRIMARY_COLOR,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('loading.gif'),
            ),
            Text(
              'Łączenie',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
