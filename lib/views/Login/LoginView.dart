import 'package:flutter/material.dart';
import 'package:tankomat/views/Login/components/Body.dart';
import 'package:firebase/firebase.dart' as firebase;
import 'package:tankomat/utils.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firebase.Auth auth;

  _LoginViewState() : auth = firebase.auth();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initializeAuth(context);
    return Scaffold(
      body: Body(
        emailController: emailController,
        passwordController: passwordController,
        onPress: () async {
          try {
            // TODO Validate email and password
            String email = emailController.text;
            String password = passwordController.text;
            await auth.signInWithEmailAndPassword(email, password);
          } catch (e) {
            // TODO Add error message display
            print(e.toString());
          }
        },
      ),
    );
  }
}
