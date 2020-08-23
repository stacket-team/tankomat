import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

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
        ? DragTarget<int>(
            builder: (
              BuildContext context,
              List<int> candidateData,
              List<dynamic> rejectedData,
            ) {
              return DottedBorder(
                radius: Radius.circular(8),
                color: Colors.orange,
                strokeWidth: 1,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Przenieś tutaj',
                        style: TextStyle(
                          fontWeight: candidateData.isNotEmpty
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            onWillAccept: (int data) => id > data + 1 || id < data,
            onAccept: (int data) => onMoved(data, id),
          )
        : Container();
  }
}
