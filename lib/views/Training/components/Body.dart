import 'package:flutter/material.dart';
import 'package:tankomat/components/Background.dart';
import 'package:tankomat/views/Training/components/Exercise.dart';
import 'package:tankomat/views/Training/components/StartExercise.dart';

class Body extends StatelessWidget {
  final bool started;
  final int time;
  final bool paused;
  final int leftPauseTime;
  final Map<String, dynamic> current;
  final Function onStartPress;
  final Function onEndPress;
  final bool runAfterPause;
  final Function toggleRunAfterPause;

  Body({
    this.started,
    this.time,
    this.current,
    this.onStartPress,
    this.onEndPress,
    this.leftPauseTime,
    this.paused,
    this.runAfterPause,
    this.toggleRunAfterPause,
  });

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            current != null
                ? started
                    ? Exercise(
                        current['name'],
                        time,
                        current['time'],
                        onEndPress,
                      )
                    : StartExercise(
                        current['name'],
                        current['description'],
                        int.parse(current['count']),
                        current['time'],
                        onStartPress,
                        paused,
                        leftPauseTime,
                        runAfterPause,
                        toggleRunAfterPause,
                      )
                : Container(),
          ],
        ),
      ),
    );
  }
}
