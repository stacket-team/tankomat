import 'package:flutter/material.dart';
import 'package:tankomat/components/Background.dart';
import 'package:tankomat/components/Loading.dart';
import 'package:tankomat/components/SocialIcon.dart';
import 'package:tankomat/components/Form.dart';
import 'package:tankomat/components/Input.dart';
import 'package:tankomat/components/Button.dart';
import 'package:tankomat/views/Register/components/SocialDivider.dart';

class Body extends StatelessWidget {
  final String email;
  final String providerString;
  final bool isLoading;
  final List<String> methods;
  final TextEditingController passwordController;
  final Function onPasswordLogin;
  final Function onGoogleLogin;
  final Function onFacebookLogin;

  Body({
    this.email,
    this.providerString,
    this.isLoading,
    this.methods,
    this.passwordController,
    this.onPasswordLogin,
    this.onGoogleLogin,
    this.onFacebookLogin,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Text(
        'Konto $email już istnieje!',
        textAlign: TextAlign.center,
      ),
      Text(
        'Zaloguj się, aby potwierdzić weryfikację $providerString',
        textAlign: TextAlign.center,
      ),
    ];
    if (isLoading) {
      children.add(Loading());
    } else {
      if (methods.contains('password')) {
        children.add(
          AuthForm(
            children: [
              Input(
                isPassword: true,
                isEmail: false,
                placeholder: 'Hasło',
                controller: passwordController,
                icon: Icons.security,
              ),
              Button(
                text: 'Zaloguj się',
                press: onPasswordLogin,
              ),
            ],
          ),
        );
        if (methods.contains('google.com') ||
            methods.contains('facebook.com')) {
          children.add(SocialDivider());
        }
      }
      List<Widget> socialIcons = [];
      if (methods.contains('google.com')) {
        socialIcons.add(SocialIcon(
          iconSrc: 'google.png',
          press: onGoogleLogin,
        ));
      }
      if (methods.contains('facebook.com')) {
        socialIcons.add(SocialIcon(
          iconSrc: 'facebook.png',
          press: onFacebookLogin,
        ));
      }
      children.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: socialIcons,
      ));
    }
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}
