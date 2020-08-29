import 'package:flutter/material.dart';
import 'package:tankomat/components/Background.dart';
import 'package:tankomat/views/Training/components/Exercise.dart';
import 'package:tankomat/views/Training/components/StartExercise.dart';

class Body extends StatelessWidget {
  final bool isLoaded;
  final bool started;
  final int time;
  final Map<String, dynamic> current;
  final Function onStartPress;
  final Function onEndPress;

  Body({
    this.isLoaded,
    this.started,
    this.time,
    this.current,
    this.onStartPress,
    this.onEndPress,
  });

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: isLoaded
              ? <Widget>[
                  started
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
                        ),
                ]
              : <Widget>[],
        ),
      ),
    );
  }
}
