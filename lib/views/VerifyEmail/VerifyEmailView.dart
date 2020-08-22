import 'package:flutter/material.dart';
import 'package:tankomat/views/VerifyEmail/components/Body.dart';
import 'package:tankomat/utils.dart' show Auth;

class VerifyEmailView extends StatelessWidget {
  final Auth auth;

  VerifyEmailView(this.auth);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        onContinuePress: () async {
          try {
            if (await auth.confirmEmailVerified()) {
              Navigator.of(context).pushNamed('/');
            } else {
              // TODO Display error about email not being verified
              print('Adres e-mail nie został potwierdzony');
            }
          } catch (e) {
            // TODO Display error about confirming email verification
            print(e.toString());
          }
        },
        onSendValidationEmailPress: () async {
          try {
            await auth.sendEmailVerification();
          } catch (e) {
            // TODO Display error about sending email verification
            print(e.toString());
          }
        },
      ),
    );
  }
}
