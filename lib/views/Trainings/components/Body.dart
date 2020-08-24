import 'package:flutter/material.dart';
import 'package:tankomat/components/Background.dart';
import 'package:tankomat/views/Trainings/components/TrainingCard.dart';
import 'package:tankomat/views/Trainings/components/NoTrainings.dart';

class Body extends StatelessWidget {
  final List trainings;
  final Function onAddTrainingPress;
  final Function onLongCardPress;

  Body({
    this.trainings,
    this.onAddTrainingPress,
    this.onLongCardPress,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    if (trainings.isEmpty) {
      children.add(NoTrainings(onAddTrainingPress));
    }

    for (MapEntry trainingEntry in trainings.asMap().entries) {
      Map training = trainingEntry.value;
      children.add(TrainingCard(
        trainingEntry.key,
        training['name'],
        training['totalTime'],
        (training['elements'] as List).length,
        onLongCardPress,
      ));
    }

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
