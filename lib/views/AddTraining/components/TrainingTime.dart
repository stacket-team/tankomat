import 'package:flutter/material.dart';
import 'package:tankomat/utils.dart' show secondsToHMS;

class TrainingTime extends StatelessWidget {
  final int time;

  TrainingTime(this.time);

  @override
  Widget build(BuildContext context) {
    return Text('Łączny czas treningu wynosi ' + secondsToHMS(time));
  }
}
