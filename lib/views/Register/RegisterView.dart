import 'package:flutter/material.dart';
import 'package:tankomat/utils.dart' show Auth;
import 'package:tankomat/views/Register/components/Body.dart';
import 'package:firebase/firebase.dart' as firebase;

class RegisterView extends StatefulWidget {
  final Auth auth;

  RegisterView(this.auth);

  @override
  _RegsiterViewState createState() => _RegsiterViewState(auth);
}

class _RegsiterViewState extends State<RegisterView> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final Auth auth;

  _RegsiterViewState(this.auth);

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        nameController: nameController,
        emailController: emailController,
        passwordController: passwordController,
        onPress: () async {
          // TODO Validate email and password
          String name = nameController.text;
          String email = emailController.text;
          String password = passwordController.text;

          try {
            await auth.createUser(name, email, password);
          } on firebase.FirebaseError catch (e) {
            if (e.code == 'auth/email-already-in-use') {
              Navigator.of(context).pushNamed(
                '/linkCredentials',
                arguments: {
                  'email': email,
                  'credential': {'password': password},
                  'providerString': 'hasłem',
                },
              );
            }
          } catch (e) {
            // TODO Add error message display
            print(e.toString());
          }
        },
        onGooglePress: () async {
          try {
            await auth.loginUserWithGoogle(context);
          } catch (e) {
            // TODO Add error message display
            print(e.toString());
          }
        },
        onFacebookPress: () async {
          try {
            await auth.loginUserWithFacebook(context);
          } catch (e) {
            // TODO Add error message display
            print(e.toString());
          }
        },
      ),
    );
  }
}
