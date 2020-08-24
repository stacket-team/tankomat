import 'package:flutter/material.dart';
import 'package:tankomat/utils.dart' show secondsToHMS, fixNoun;

class BigText extends StatelessWidget {
  final String text;

  BigText(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 22,
        ),
      ),
    );
  }
}

class SmallText extends StatelessWidget {
  final String text;

  SmallText(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Text(text),
    );
  }
}

class IconButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onPress;
  final bool isAction;

  IconButton(
    this.text,
    this.icon,
    this.isAction,
    this.onPress,
  );

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPress,
      child: Container(
        width: 120,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isAction ? Colors.orange[400] : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isAction ? Colors.transparent : Colors.orange[400],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(text),
            Icon(icon),
          ],
        ),
      ),
    );
  }
}

class TrainingCard extends StatelessWidget {
  final int id;
  final String name;
  final int totalTime;
  final int exercisesCount;
  final Function onLongPress;

  TrainingCard(
    this.id,
    this.name,
    this.totalTime,
    this.exercisesCount,
    this.onLongPress,
  );

  @override
  Widget build(BuildContext context) {
    String noun = fixNoun(exercisesCount, 'ćwicze', 'nie', 'nia', 'ń');
    return GestureDetector(
      onLongPress: onLongPress(id),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: id % 2 == 0 ? Colors.grey[100] : Colors.white,
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                BigText(name),
                IconButton(
                  'Rozpocznij',
                  Icons.arrow_forward_ios,
                  true,
                  () {}, // TODO Redirect to training mode
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SmallText('$exercisesCount $noun'),
                    Text('•'),
                    SmallText(secondsToHMS(totalTime)),
                  ],
                ),
                IconButton(
                  'Opublikuj',
                  Icons.public,
                  false,
                  () {}, // TODO Redirect to publishing
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
