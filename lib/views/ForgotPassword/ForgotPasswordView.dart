import 'package:flutter/material.dart';
import 'package:tankomat/views/ForgotPassword/compontents/Body.dart';
import 'package:tankomat/utils.dart';

class ForgotPasswordView extends StatefulWidget {
  final Map arguments;

  ForgotPasswordView(this.arguments);

  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState(arguments);
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final Map arguments;
  final TextEditingController emailController;

  _ForgotPasswordViewState(this.arguments)
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
            await resetPassword(emailController.text);
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
