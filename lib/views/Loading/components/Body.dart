import 'package:flutter/material.dart';
import 'package:tankomat/components/Background.dart';
import 'package:tankomat/components/Loading.dart';
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
            Loading(
              size: 192,
              width: 8,
              color: Colors.white,
            ),
            Container(
              height: 50,
            ),
            Text(
              'Łączenie',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
