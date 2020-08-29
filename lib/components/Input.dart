import 'package:flutter/material.dart';
import 'package:tankomat/components/TextFieldContainer.dart';

class Input extends StatelessWidget {
  final String placeholder;
  final IconData icon;
  final ValueChanged<String> onChange;
  final TextEditingController controller;
  final bool isPassword;
  final bool isEmail;
  final Color backgroundColor;

  const Input({
    Key key,
    this.placeholder,
    this.icon,
    this.onChange,
    this.controller,
    this.isPassword,
    this.isEmail,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      backgroundColor: backgroundColor,
      child: TextFormField(
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        onChanged: onChange,
        controller: controller,
        cursorColor: Colors.white,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Colors.white,
          ),
          hintText: placeholder,
          hintStyle: TextStyle(color: Colors.white),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
