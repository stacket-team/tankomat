import 'package:flutter/material.dart';
import 'package:tankomat/components/Form.dart';
import 'package:tankomat/views/Login/components/Background.dart';
import 'package:tankomat/views/Login/components/DontHaveAnAccount.dart';
import 'package:tankomat/components/Button.dart';
import 'package:tankomat/components/Input.dart';

import '../../../components/Input.dart';

class Body extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function onPress;

  Body({
    Key key,
    this.emailController,
    this.passwordController,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AuthForm(
              children: [
                Input(
                  isPassword: false,
                  isEmail: true,
                  placeholder: 'E-mail',
                  controller: emailController,
                ),
                Input(
                  isPassword: true,
                  isEmail: false,
                  placeholder: 'Hasło',
                  controller: passwordController,
                ),
                Button(
                  text: 'Zaloguj się',
                  press: onPress,
                ),
                DontHaveAnAccount(
                  text: 'Nie masz konta? Zarejestruj się tutaj!',
                  onPress: () {
                    Navigator.of(context).pushNamed('/register');
                    print('i am here');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
