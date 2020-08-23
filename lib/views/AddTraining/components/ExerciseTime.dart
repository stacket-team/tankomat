import 'package:flutter/material.dart';
import 'package:tankomat/utils.dart' show secondsToHMS;

class ExerciseTime extends StatelessWidget {
  final int time;
  final bool hide;

  ExerciseTime(this.time, this.hide);

  @override
  Widget build(BuildContext context) {
    return hide ? Container() : Text(secondsToHMS(time));
  }
}
