import 'package:flutter/material.dart';

class TrainingSubmit extends StatelessWidget {
  final Function onPress;

  TrainingSubmit(this.onPress);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPress,
      color: Colors.orange[300],
      padding: EdgeInsets.all(8),
      child: Text('Zapisz trening'),
    );
  }
}
