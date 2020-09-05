import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:tankomat/constants.dart';

class ExerciseTarget extends StatelessWidget {
  final int id;
  final Function onMoved;
  final bool isCardMoving;
  final int movingCardID;

  ExerciseTarget(
    this.id,
    this.onMoved,
    this.isCardMoving,
    this.movingCardID,
  );

  @override
  Widget build(BuildContext context) {
    return (isCardMoving && (id > movingCardID + 1 || id < movingCardID))
        ? FlatButton(
            onPressed: onMoved(id),
            child: DottedBorder(
              radius: Radius.circular(8),
              color: PRIMARY_COLOR,
              strokeWidth: 1,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Text('Kliknij tutaj, aby przenieść'),
              ),
            ),
          )
        : Container();
  }
}
