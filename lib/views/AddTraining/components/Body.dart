import 'package:flutter/material.dart';
import 'package:tankomat/components/Background.dart';

class Body extends StatelessWidget {
  final Color saveColor;
  final String saveText;
  final List<Map<String, TextEditingController>> controllers;
  final Function onAddFieldPress;

  Body({
    this.saveText,
    this.saveColor,
    this.controllers,
    this.onAddFieldPress,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(saveText),
          Icon(
            Icons.save,
            color: saveColor,
          ),
        ],
      ),
    ];

    for (Map<String, TextEditingController> controllersGroup in controllers) {
      children.add(Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.orange[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: controllersGroup['name'],
              decoration: InputDecoration(
                hintText: 'Ćwiczenie',
              ),
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              controller: controllersGroup['description'],
              decoration: InputDecoration(
                hintText: 'Opis',
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: controllersGroup['count'],
              decoration: InputDecoration(
                hintText: 'Ilość',
              ),
            ),
            TextField(
              controller: controllersGroup['duration'],
              decoration: InputDecoration(
                hintText: 'Czas',
              ),
            ),
          ],
        ),
      ));
    }

    children.add(Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          onPressed: onAddFieldPress,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.add,
                color: Colors.black,
              ),
              Text('Dodaj następne ćwiczenie'),
            ],
          ),
        ),
      ],
    ));

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
