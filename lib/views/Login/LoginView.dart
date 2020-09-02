import 'package:flutter/material.dart';
import 'package:tankomat/views/Login/components/Body.dart';
import 'package:tankomat/utils.dart' show Auth;

class LoginView extends StatefulWidget {
  final Auth auth;

  LoginView(this.auth);

  @override
  _LoginViewState createState() => _LoginViewState(auth);
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final Auth auth;

  _LoginViewState(this.auth);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zaloguj się'),
      ),
      body: Body(),
      // body: Body(
      //   emailController: emailController,
      //   passwordController: passwordController,
      //   onPress: () async {
      //     // TODO Validate email and password
      //     String email = emailController.text;
      //     String password = passwordController.text;

      //     try {
      //       await auth.loginUser(email, password);
      //     } catch (e) {
      //       // TODO Add error message display
      //       print(e.toString());
      //       if (e.code == 'auth/wrong-password') {
      //         List<String> methods = await auth.getLoginMethods(email);
      //         if (methods.contains('password') == false) {
      //           Navigator.of(context).pushNamed(
      //             '/linkCredentials',
      //             arguments: {
      //               'email': email,
      //               'credential': {'password': password},
      //               'providerString': 'hasłem',
      //             },
      //           );
      //         }
      //       }
      //     }
      //   },
      //   onGooglePress: () async {
      //     try {
      //       await auth.loginUserWithGoogle(context);
      //     } catch (e) {
      //       // TODO Add error message display
      //       print(e.toString());
      //     }
      //   },
      //   onFacebookPress: () async {
      //     try {
      //       await auth.loginUserWithFacebook(context);
      //     } catch (e) {
      //       // TODO Add error message display
      //       print(e.toString());
      //     }
      //   },
      //   onForgotPasswordPress: () {
      //     Navigator.of(context).pushNamed(
      //       '/forgotPassword',
      //       arguments: {'email': emailController.text},
      //     );
      //   },
      // ),
    );
  }
}
