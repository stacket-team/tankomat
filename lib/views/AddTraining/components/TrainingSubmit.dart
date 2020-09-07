import 'package:flutter/material.dart';
import 'package:tankomat/constants.dart';

class TrainingSubmit extends StatelessWidget {
  final Function onPress;

  TrainingSubmit(this.onPress);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPress,
      color: PRIMARY_COLOR,
      padding: EdgeInsets.all(8),
      child: Text('Zapisz trening'),
    );
  }
}
