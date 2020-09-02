import 'package:flutter/material.dart';
import 'package:tankomat/components/DefaultButton.dart';
import 'package:tankomat/components/custom_suffix_icon.dart';
import 'package:tankomat/components/form_error.dart';
import 'package:tankomat/constants.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          buildEmailFormField(),
          SizedBox(height: 20),
          buildPasswordFormField(),
          SizedBox(height: 20),
          Row(
            children: [
              Text(''),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed('/forgotPassword'),
                child: Text(
                  'Zapomniałeś hasła?',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: 20),
          DefaultButton(
            text: 'Zaloguj się',
            onPress: () {
              if (_formKey.currentState.validate()) {
                // TODO Log in
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
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
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onChanged: (value) {
        if (value.isNotEmpty && errors.contains(passwordNullError)) {
          setState(() {
            errors.remove(passwordNullError);
          });
        } else if (value.length >= 8 && errors.contains(shortPasswordError)) {
          setState(() {
            errors.remove(shortPasswordError);
          });
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty && !errors.contains(passwordNullError)) {
          setState(() {
            errors.add(passwordNullError);
          });
        } else if (value.length < 8 && !errors.contains(shortPasswordError)) {
          setState(() {
            errors.add(shortPasswordError);
          });
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Hasło',
        hintText: 'Hasło',
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSuffixIcon(iconName: Icons.lock),
      ),
    );
  }
}
