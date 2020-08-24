import 'package:flutter/material.dart';
import 'package:tankomat/components/Background.dart';
import 'package:tankomat/views/AddTraining/components/ExerciseAdd.dart';
import 'package:tankomat/views/AddTraining/components/ExerciseCard.dart';
import 'package:tankomat/views/AddTraining/components/ExerciseTarget.dart';
import 'package:tankomat/views/AddTraining/components/ExerciseTime.dart';
import 'package:tankomat/views/AddTraining/components/SaveStatus.dart';
import 'package:tankomat/views/AddTraining/components/TrainingName.dart';
import 'package:tankomat/views/AddTraining/components/TrainingSubmit.dart';
import 'package:tankomat/views/AddTraining/components/TrainingTime.dart';

class Body extends StatelessWidget {
  final Color saveColor;
  final String saveText;
  final TextEditingController nameController;
  final List<Map<String, TextEditingController>> controllers;
  final List<int> times;
  final int totalTime;
  final Function onCardMoved;
  final Function onAddFieldPress;
  final Function showTargets;
  final Function hideTargets;
  final bool isCardMoving;
  final int movingCardID;
  final Function onSubmitPress;

  Body({
    this.saveText,
    this.saveColor,
    this.nameController,
    this.controllers,
    this.times,
    this.totalTime,
    this.onCardMoved,
    this.onAddFieldPress,
    this.showTargets,
    this.hideTargets,
    this.isCardMoving,
    this.movingCardID,
    this.onSubmitPress,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    children.add(SaveStatus(saveText, saveColor));

    children.add(TrainingName(nameController));

    children.add(ExerciseTarget(
      0,
      onCardMoved,
      isCardMoving,
      movingCardID,
    ));

    for (MapEntry<int, Map<String, TextEditingController>> entry
        in controllers.asMap().entries) {
      Map<String, TextEditingController> controllersGroup = entry.value;

      children.add(ExerciseCard(
        entry.key,
        controllersGroup['name'],
        controllersGroup['description'],
        controllersGroup['count'],
        controllersGroup['duration'],
        showTargets,
        hideTargets,
      ));

      if (times.length > entry.key) {
        children.add(ExerciseTime(times[entry.key], isCardMoving));
      }

      children.add(ExerciseTarget(
        entry.key + 1,
        onCardMoved,
        isCardMoving,
        movingCardID,
      ));
    }

    children.add(ExerciseAdd(onAddFieldPress));

    children.add(TrainingTime(totalTime));

    children.add(TrainingSubmit(onSubmitPress));

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}
