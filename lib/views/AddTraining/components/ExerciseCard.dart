import 'package:flutter/material.dart';
import 'package:tankomat/constants.dart';

class ExerciseCard extends StatelessWidget {
  final TextEditingController name;
  final TextEditingController description;
  final TextEditingController count;
  final TextEditingController duration;
  final List<int> id;
  final Function toggleCardSelection;
  final bool isCardSelected;
  final List<List<int>> selectedCardsID;

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
    // TODO Extendalbe Cards
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: PRIMARY_COLOR,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Checkbox(
                value: selectedCardsID
                    .map((chain) => chain.join(','))
                    .contains(id.join(',')),
                onChanged: toggleCardSelection(id),
              ),
              isCardSelected
                  ? Text(
                      name.text.isEmpty ? 'Ćwiczenie' : name.text,
                    )
                  : Flexible(
                      child: TextField(
                        controller: name,
                        decoration: InputDecoration(
                          hintText: 'Ćwiczenie',
                        ),
                      ),
                    ),
            ],
          ),
          isCardSelected
              ? Container()
              : Row(
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        controller: description,
                        decoration: InputDecoration(
                          hintText: 'Opis',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: Column(
                        children: <Widget>[
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
                  ],
                ),
        ],
      ),
    );
  }
}
