import 'package:flutter/material.dart';
import 'package:tankomat/views/ForgotPassword/compontents/Body.dart';
import 'package:tankomat/utils.dart' show Auth;

class ForgotPasswordView extends StatefulWidget {
  final Auth auth;
  final Map arguments;

  ForgotPasswordView(this.auth, this.arguments);

  @override
  _ForgotPasswordViewState createState() =>
      _ForgotPasswordViewState(auth, arguments);
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final Auth auth;
  final Map arguments;
  final TextEditingController emailController;

  _ForgotPasswordViewState(this.auth, this.arguments)
      : emailController = TextEditingController(text: arguments['email']);

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        emailController: emailController,
        onSendPress: () async {
          try {
            await auth.resetPassword(emailController.text);
            Navigator.of(context).pushNamed('/login');
          } catch (e) {
            // TODO Add error display
            print(e.toString());
          }
        },
      ),
    );
  }
}
