import 'package:flutter/material.dart';
import 'package:tankomat/views/Login/components/Background.dart';
import 'package:tankomat/views/Login/components/DontHaveAnAccount.dart';
import 'package:tankomat/components/Button.dart';
import 'package:tankomat/components/Input.dart';
import 'package:tankomat/views/Register/RegisterView.dart';

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
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Input(
              isPassword: false,
              placeholder: 'E-mail',
              controller: emailController,
            ),
            Input(
              isPassword: true,
              placeholder: 'Hasło',
              controller: passwordController,
            ),
            Button(
              text: 'Zaloguj się',
              press: onPress,
            ),
            // SizedBox(height: size.height * 0.03),
            DontHaveAnAccount(
              text: 'Nie masz konta? Zarejestruj się tutaj!',
              onPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterView()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
