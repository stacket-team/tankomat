import 'package:flutter/material.dart';
import 'package:tankomat/views/Register/components/Body.dart';
import 'package:firebase/firebase.dart' as firebase;
import 'package:firebase/firestore.dart' as firestore;
import 'package:tankomat/views/Login/LoginView.dart';

class RegisterView extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firebase.Auth auth;
  final firestore.CollectionReference ref;

  RegisterView()
      : auth = firebase.auth(),
        ref = firebase.firestore().collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        nameController: nameController,
        emailController: emailController,
        passwordController: passwordController,
        onPress: () async {
          bool trySignin = false;
          // TODO Validate email and password
          String name = nameController.text;
          String email = emailController.text;
          String password = passwordController.text;
          try {
            String uid =
                (await auth.createUserWithEmailAndPassword(email, password))
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
                  (await auth.signInWithEmailAndPassword(email, password)).user;
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
    );
  }
}
