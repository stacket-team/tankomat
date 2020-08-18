import 'package:flutter/material.dart';
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

  Body({
    Key key,
    this.nameController,
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
                  isEmail: false,
                  placeholder: 'Imię',
                  controller: nameController,
                  icon: Icons.person,
                ),
                Input(
                  isPassword: false,
                  isEmail: true,
                  placeholder: 'E-mail',
                  controller: emailController,
                  icon: Icons.email,
                ),
                Input(
                  isPassword: true,
                  isEmail: false,
                  placeholder: 'Hasło',
                  controller: passwordController,
                  icon: Icons.security,
                ),
                Button(
                  text: 'Zarejestruj się',
                  press: onPress,
                ),
              ],
            ),
            SocialDivider(),
            // TODO Fix svg not showing
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[],
            // ),
          ],
        ),
      ),
    );
  }
}
