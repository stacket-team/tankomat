import 'package:flutter/material.dart';
import 'package:tankomat/components/Background.dart';
import 'package:tankomat/components/social_card.dart';
import 'package:tankomat/views/Login/components/sign_in_form.dart';

import 'no_account_text.dart';

class Body extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function onPress;
  final Function onGooglePress;
  final Function onFacebookPress;
  final Function onForgotPasswordPress;

  Body({
    Key key,
    this.emailController,
    this.passwordController,
    this.onPress,
    this.onGooglePress,
    this.onFacebookPress,
    this.onForgotPasswordPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Text(
                    'Witaj z powrotem!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Zaloguj się za pomocą e-mail \n lub kontunuj za pomocą mediów społecznościowych',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF8B8B8B),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  SignInForm(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SocialCard(
                        icon: 'assets/facebook.png',
                        onPress: () {},
                      ),
                      SocialCard(
                        icon: 'assets/google.png',
                        onPress: () {},
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  NoAccountText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
