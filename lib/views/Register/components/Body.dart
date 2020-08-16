import 'package:flutter/material.dart';
import 'package:tankomat/views/Register/components/Background.dart';
import 'package:tankomat/views/Register/components/SocialDivider.dart';
import 'package:tankomat/components/Button.dart';
import 'package:tankomat/components/Input.dart';
import 'package:firebase/firebase.dart' as firebase;
import 'package:firebase/firestore.dart' as firestore;
import 'package:tankomat/views/Login/LoginView.dart';

class Body extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firebase.Auth auth;
  final firestore.CollectionReference ref;

  Body()
      : auth = firebase.auth(),
        ref = firebase.firestore().collection('users');

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
              placeholder: 'Nazwa',
              controller: nameController,
            ),
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
                String name = nameController.text;
                String email = emailController.text;
                String password = passwordController.text;
                try {
                  String uid = (await auth.createUserWithEmailAndPassword(
                          email, password))
                      .user
                      .uid;

                  Map<String, dynamic> userData = {
                    'name': name,
                    'type': null,
                    'history': [],
                  };

                  try {
                    await ref.doc(uid).set(userData);
                  } catch (e) {
                    print(e.toString());
                  }

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
                    firebase.User user =
                        (await auth.signInWithEmailAndPassword(email, password))
                            .user;
                    if (user != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginView()),
                      );
                    }
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
