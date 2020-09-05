import 'package:flutter/material.dart';
import 'package:tankomat/constants.dart';

class ExerciseCard extends StatelessWidget {
  final TextEditingController name;
  final TextEditingController description;
  final TextEditingController count;
  final TextEditingController duration;
  final int id;
  final Function toggleCardSelection;
  final bool isCardSelected;
  final List<int> selectedCardsID;

  ExerciseCard(
    this.id,
    this.name,
    this.description,
    this.count,
    this.duration,
    this.toggleCardSelection,
    this.isCardSelected,
    this.selectedCardsID,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: toggleCardSelection(id),
      child: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: PRIMARY_COLOR,
          borderRadius: BorderRadius.circular(12),
        ),
        child: isCardSelected
            ? Row(
                children: <Widget>[
                  selectedCardsID.contains(id)
                      ? Icon(
                          Icons.check_circle,
                          color: PRIMARY_LIGHT_COLOR,
                        )
                      : Container(),
                  Text(
                    name.text == '' ? 'Ćwiczenie' : name.text,
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: name,
                    decoration: InputDecoration(
                      hintText: 'Ćwiczenie',
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.multiline,
                    controller: description,
                    decoration: InputDecoration(
                      hintText: 'Opis',
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: count,
                    decoration: InputDecoration(
                      hintText: 'Ilość',
                    ),
                  ),
                  TextField(
                    controller: duration,
                    decoration: InputDecoration(
                      hintText: 'Czas',
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
