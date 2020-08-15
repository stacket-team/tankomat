import 'package:flutter/material.dart';
import 'package:tankomat/views/Register/components/Background.dart';
import 'package:tankomat/views/Register/components/SocialDivider.dart';
import 'package:tankomat/components/Button.dart';
import 'package:tankomat/components/Input.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Input(
              isPassword: false,
              placeholder: 'E-mail',
              onChange: (value) {},
            ),
            Input(
              isPassword: true,
              placeholder: 'Haslo',
              onChange: (value) {},
            ),
            Button(
              text: 'zarejestruj sie',
              press: () {},
            ),
            SizedBox(height: size.height * 0.03),
            SocialDivider(),
          ],
        ),
      ),
    );
  }
}
