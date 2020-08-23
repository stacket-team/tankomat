import 'package:flutter/material.dart';

class ExerciseCard extends StatelessWidget {
  final TextEditingController name;
  final TextEditingController description;
  final TextEditingController count;
  final TextEditingController duration;
  final int id;
  final Function showTargets;
  final Function hideTargets;

  ExerciseCard(
    this.id,
    this.name,
    this.description,
    this.count,
    this.duration,
    this.showTargets,
    this.hideTargets,
  );

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<int>(
      child: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.orange[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
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
      childWhenDragging: Container(),
      feedback: Container(
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.orange[300],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          name.text.isEmpty ? 'Ćwiczenie' : name.text,
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 16,
            decoration: TextDecoration.none,
          ),
        ),
      ),
      dragAnchor: DragAnchor.pointer,
      data: id,
      onDragStarted: () => showTargets(id),
      onDragEnd: (details) => hideTargets(),
    );
  }
}
