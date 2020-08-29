import 'package:flutter/material.dart';
import 'package:tankomat/constants.dart';
import 'package:tankomat/components/Form.dart';
import 'package:tankomat/components/SocialIcon.dart';
import 'package:tankomat/components/Background.dart';
import 'package:tankomat/views/Register/components/SocialDivider.dart';
import 'package:tankomat/components/Button.dart';
import 'package:tankomat/components/Input.dart';

class Body extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function onPress;
  final Function onGooglePress;
  final Function onFacebookPress;

  Body({
    Key key,
    this.nameController,
    this.emailController,
    this.passwordController,
    this.onPress,
    this.onGooglePress,
    this.onFacebookPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      backgroundColor: PRIMARY_COLOR,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AuthForm(
              children: [
                Input(
                  backgroundColor: SECONDARY_COLOR,
                  isPassword: false,
                  isEmail: false,
                  placeholder: 'Imię',
                  controller: nameController,
                  icon: Icons.person,
                ),
                Input(
                  backgroundColor: SECONDARY_COLOR,
                  isPassword: false,
                  isEmail: true,
                  placeholder: 'E-mail',
                  controller: emailController,
                  icon: Icons.email,
                ),
                Input(
                  backgroundColor: SECONDARY_COLOR,
                  isPassword: true,
                  isEmail: false,
                  placeholder: 'Hasło',
                  controller: passwordController,
                  icon: Icons.security,
                ),
                Button(
                  backgroundColor: SECONDARY_COLOR,
                  text: 'Zarejestruj się',
                  press: onPress,
                ),
              ],
            ),
            SocialDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocialIcon(
                  iconSrc: 'google.png',
                  press: onGooglePress,
                ),
                SocialIcon(
                  iconSrc: 'facebook.png',
                  press: onFacebookPress,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
