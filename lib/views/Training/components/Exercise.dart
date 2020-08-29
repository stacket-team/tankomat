import 'package:flutter/material.dart';
import 'package:tankomat/views/Training/components/Button.dart';
import 'package:tankomat/views/Training/components/Text.dart';
import 'package:tankomat/utils.dart' show secondsToHMS;

class Exercise extends StatelessWidget {
  final String name;
  final int time;
  final int totalTime;
  final bool isOvertime;
  final Function onEndPress;

  Exercise(this.name, this.time, this.totalTime, this.onEndPress)
      : isOvertime = totalTime - time < 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SmallText(name),
          Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              SizedBox(
                width: 150,
                height: 150,
                child: isOvertime
                    ? CircularProgressIndicator(
                        strokeWidth: 8,
                      )
                    : CircularProgressIndicator(
                        value: time / totalTime,
                        strokeWidth: 8,
                      ),
              ),
              BigText(secondsToHMS(
                  isOvertime ? time - totalTime : totalTime - time)),
            ],
          ),
          EndButton(
            'Zakończ',
            onEndPress,
          ),
        ],
      ),
    );
  }
}
