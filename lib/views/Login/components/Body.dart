import 'package:flutter/material.dart';
import 'package:tankomat/views/Login/components/DontHaveAnAccount.dart';
import '../../../components/Button.dart';
import '../../../components/Input.dart';
import '../../Register/RegisterView.dart';
import '../../Register/components/Background.dart';

class Body extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login() async {
    // TODO Add login logic
  }

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
              press: login,
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
