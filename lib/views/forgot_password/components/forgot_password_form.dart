import 'package:flutter/material.dart';
import 'package:tankomat/components/DefaultButton.dart';
import 'package:tankomat/components/custom_suffix_icon.dart';
import 'package:tankomat/components/form_error.dart';
import 'package:tankomat/constants.dart';
import 'package:tankomat/views/Login/components/no_account_text.dart';

class ForgotPasswordForm extends StatefulWidget {
  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) {
              if (value.isNotEmpty && errors.contains(emailNullError)) {
                setState(() {
                  errors.remove(emailNullError);
                });
              } else if (emailValidatorRegExp.hasMatch(value) &&
                  errors.contains(invalidEmailError)) {
                setState(() {
                  errors.remove(invalidEmailError);
                });
              }
              return null;
            },
            validator: (value) {
              if (value.isEmpty && !errors.contains(emailNullError)) {
                setState(() {
                  errors.add(emailNullError);
                });
              } else if (!emailValidatorRegExp.hasMatch(value) &&
                  !errors.contains(invalidEmailError)) {
                setState(() {
                  errors.add(invalidEmailError);
                });
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'E-mail',
              hintText: 'E-mail',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSuffixIcon(iconName: Icons.email),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          FormError(errors: errors),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          DefaultButton(
            text: 'Wyślij link',
            onPress: () {
              if (_formKey.currentState.validate()) {
                // TODO Send link
              }
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          NoAccountText(),
        ],
      ),
    );
  }
}
