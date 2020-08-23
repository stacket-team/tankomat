import 'package:flutter/material.dart';

class ExerciseAdd extends StatelessWidget {
  final Function onAddFieldPress;

  ExerciseAdd(this.onAddFieldPress);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          onPressed: onAddFieldPress,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.add,
                color: Colors.black,
              ),
              Text('Dodaj następne ćwiczenie'),
            ],
          ),
        ),
      ],
    );
  }
}
