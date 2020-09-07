import 'package:flutter/material.dart';
import 'package:tankomat/constants.dart';

class TrainingName extends StatelessWidget {
  final TextEditingController controller;

  TrainingName(this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: PRIMARY_COLOR,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Nowy trening',
        ),
      ),
    );
  }
}
