import 'package:flutter/material.dart';
import 'package:tankomat/views/forgot_password/components/body.dart';

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zapomniałeś hasła?'),
      ),
      body: Body(),
    );
  }
}
