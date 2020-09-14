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
  final List<int> selectedCardID;
  final bool isCardSelected;
  final List<List<int>> selectedCardsID;
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

  List<Widget> buildExercises(
    List<Map<String, dynamic>> controllers,
    List<int> offset,
  ) {
    List<Widget> children = [];
    controllers.asMap().forEach((key, element) {
      List<int> chain = [key];
      chain.insertAll(0, offset);
      if (element.containsKey('elements')) {
        List<int> firstChain = [0];
        firstChain.insertAll(0, chain);

        children.add(Group(
          chain,
          element['count'],
          ExerciseTarget(
            firstChain,
            onCardMoved,
            isCardMoving,
            selectedCardID,
          ),
          buildExercises(element['elements'], chain),
          toggleCardSelection,
          selectedCardsID,
          isCardSelected,
        ));

        List<int> nextChain = [key + 1];
        nextChain.insertAll(0, offset);
        children.add(ExerciseTarget(
          nextChain,
          onCardMoved,
          isCardMoving,
          selectedCardID,
        ));
      } else {
        children.add(ExerciseCard(
          chain,
          element['name'],
          element['description'],
          element['count'],
          element['duration'],
          toggleCardSelection,
          isCardSelected,
          selectedCardsID,
        ));

        // TODO Add time display
        // if (times.length > globalKey) {
        //   children.add(ExerciseTime(times[globalKey], isCardMoving));
        // }

        List<int> nextChain = [key + 1];
        nextChain.insertAll(0, offset);
        children.add(ExerciseTarget(
          nextChain,
          onCardMoved,
          isCardMoving,
          selectedCardID,
        ));
      }
    });
    return children;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    children.add(SaveStatus(saveText, saveColor));

    children.add(TrainingName(nameController));

    children.add(ExerciseTarget(
      [0],
      onCardMoved,
      isCardMoving,
      selectedCardID,
    ));

    children.addAll(buildExercises(controllers, []));

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
