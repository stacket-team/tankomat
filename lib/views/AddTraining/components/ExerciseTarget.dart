import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:tankomat/constants.dart';

class ExerciseTarget extends StatelessWidget {
  final List<int> id;
  final Function onMoved;
  final bool isCardMoving;
  final List<int> movingCardID;

  ExerciseTarget(
    this.id,
    this.onMoved,
    this.isCardMoving,
    this.movingCardID,
  );

  bool isDisplayable() {
    String sid = id.join(',');
    String mid0 = movingCardID.join(',');
    movingCardID.last += 1;
    String mid1 = movingCardID.join(',');
    movingCardID.last -= 1;
    return !(id.length == movingCardID.length && (sid == mid0 || sid == mid1));
  }

  @override
  Widget build(BuildContext context) {
    return isCardMoving && isDisplayable()
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
