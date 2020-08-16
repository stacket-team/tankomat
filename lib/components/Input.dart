import 'package:flutter/material.dart';
import 'package:tankomat/components/TextFieldContainer.dart';

class Input extends StatelessWidget {
  final String placeholder;
  final IconData icon;
  final ValueChanged<String> onChange;
  final TextEditingController controller;
  final bool isPassword;
  final bool isEmail;
  const Input({
    Key key,
    this.placeholder,
    this.icon = Icons.person,
    this.onChange,
    this.controller,
    this.isPassword,
    this.isEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        onChanged: onChange,
        controller: controller,
        cursorColor: Color(0xFF6F35A5),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Color(0xFF6F35A5),
          ),
          hintText: placeholder,
          hintStyle: TextStyle(color: Colors.white),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
