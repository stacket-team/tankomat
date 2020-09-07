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
import 'package:tankomat/views/AddTraining/components/Group.dart';

class Body extends StatelessWidget {
  final Color saveColor;
  final String saveText;
  final TextEditingController nameController;
  final List<Map<String, dynamic>> controllers;
  final List<int> times;
  final int totalTime;
  final Function onCardMoved;
  final Function onAddFieldPress;
  final Function toggleCardSelection;
  final bool isCardMoving;
  final int selectedCardID;
  final bool isCardSelected;
  final List<int> selectedCardsID;
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
    this.toggleCardSelection,
    this.isCardMoving,
    this.isCardSelected,
    this.selectedCardID,
    this.selectedCardsID,
    this.onSubmitPress,
  });

  Map buildExercises(List<Map<String, dynamic>> controllers, int offset) {
    List<Widget> children = [];
    int key = offset;
    controllers.forEach((element) {
      if (element.containsKey('elements')) {
        Map res = buildExercises(element['elements'], key);
        key += res['offset'];
        children.add(Group(
          element['count'],
          res['elements'],
        ));
      } else {
        int globalKey = key + offset;
        key += 1;

        // print(globalKey);

        children.add(ExerciseCard(
          globalKey,
          element['name'],
          element['description'],
          element['count'],
          element['duration'],
          toggleCardSelection,
          isCardSelected,
          selectedCardsID,
        ));

        if (times.length > globalKey) {
          children.add(ExerciseTime(times[globalKey], isCardMoving));
        }

        children.add(ExerciseTarget(
          globalKey + 1,
          onCardMoved,
          isCardMoving,
          selectedCardID,
        ));
      }
    });
    return {
      'elements': children,
      'offset': key,
    };
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    children.add(SaveStatus(saveText, saveColor));

    children.add(TrainingName(nameController));

    children.add(ExerciseTarget(
      0,
      onCardMoved,
      isCardMoving,
      selectedCardID,
    ));

    children.addAll(buildExercises(controllers, 0)['elements']);

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
