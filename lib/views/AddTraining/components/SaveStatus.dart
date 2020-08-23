import 'package:flutter/material.dart';

class SaveStatus extends StatelessWidget {
  final String saveText;
  final Color saveColor;

  SaveStatus(this.saveText, this.saveColor);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(saveText),
        Icon(
          Icons.save,
          color: saveColor,
        ),
      ],
    );
  }
}
