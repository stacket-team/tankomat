import 'package:flutter/material.dart';
import 'package:tankomat/views/Register/components/Background.dart';
import 'package:tankomat/views/Register/components/SocialDivider.dart';
import 'package:tankomat/components/Button.dart';
import 'package:tankomat/components/Input.dart';
import 'package:firebase/firebase.dart' as firebase;
import 'package:tankomat/views/Login/LoginView.dart';

class Body extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firebase.Auth auth;

  Body() : auth = firebase.auth() {
    auth.onAuthStateChanged.listen((firebase.User user) {
      if (user != null) {
        // TODO Redirect to Login view
      }
    });
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
              placeholder: 'Haslo',
              controller: passwordController,
            ),
            Button(
              text: 'zarejestruj sie',
              press: () async {
                bool trySignin = false;
                // TODO Validate email and password
                String email = emailController.text;
                String password = passwordController.text;
                try {
                  await auth.createUserWithEmailAndPassword(email, password);
                  // TODO Add account to /users in Firestore
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginView()),
                  );
                } on firebase.FirebaseError catch (e) {
                  if (e.code == 'auth/email-already-in-use') {
                    trySignin = true;
                  }
                } catch (e) {
                  // TODO Add error message display
                  print(e.toString());
                }

                if (trySignin) {
                  try {
                    await auth.signInWithEmailAndPassword(email, password);
                  } catch (e) {
                    // TODO Add error message display
                    print(e.toString());
                  }
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            SocialDivider(),
          ],
        ),
      ),
    );
  }
}
