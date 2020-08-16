import 'package:flutter/material.dart';
import 'package:tankomat/components/Form.dart';
import 'package:tankomat/views/Register/components/Background.dart';
import 'package:tankomat/views/Register/components/SocialDivider.dart';
import 'package:tankomat/components/Button.dart';
import 'package:tankomat/components/Input.dart';

class Body extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function onPress;

  Body(
      {Key key,
      this.nameController,
      this.emailController,
      this.passwordController,
      this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                ),
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
                  text: 'Zarejestruj się',
                  press: onPress,
                ),
              ],
            ),
            SocialDivider(),
            // SizedBox(height: size.height * 0.03),
            // SocialDivider(),
          ],
        ),
      ),
    );
  }
}
