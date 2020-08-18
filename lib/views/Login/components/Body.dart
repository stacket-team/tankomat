import 'package:flutter/material.dart';
import 'package:tankomat/components/Form.dart';
import 'package:tankomat/components/Background.dart';
import 'package:tankomat/views/Login/components/DontHaveAnAccount.dart';
import 'package:tankomat/components/Button.dart';
import 'package:tankomat/components/Input.dart';
import 'package:tankomat/components/Input.dart';

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
                SizedBox(
                  height: 150.0,
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 20.0),
                Input(
                  isPassword: false,
                  isEmail: true,
                  placeholder: 'E-mail',
                  controller: emailController,
                  icon: Icons.person,
                ),
                Input(
                  isPassword: true,
                  isEmail: false,
                  placeholder: 'Hasło',
                  controller: passwordController,
                  icon: Icons.email,
                ),
                Button(
                  text: 'Zaloguj się',
                  press: onPress,
                ),
                DontHaveAnAccount(
                  text: 'Nie masz konta? Zarejestruj się tutaj!',
                  onPress: () {
                    Navigator.of(context).pushNamed('/register');
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
