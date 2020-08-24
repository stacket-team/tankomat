import 'package:flutter/material.dart';

class NoTrainings extends StatelessWidget {
  final Function onPress;

  NoTrainings(this.onPress);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Text('Brak treningów'),
          FlatButton(
            onPressed: onPress,
            child: Text('Dodaj pierwszy!'),
          ),
        ],
      ),
    );
  }
}
