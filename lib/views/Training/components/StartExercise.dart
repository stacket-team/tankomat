import 'package:flutter/material.dart';
import 'package:tankomat/views/Training/components/Button.dart';
import 'package:tankomat/views/Training/components/Text.dart';
import 'package:tankomat/utils.dart' show secondsToHMS, fixNoun;

class StartExercise extends StatelessWidget {
  final String name;
  final String description;
  final int count;
  final int time;
  final Function onStartPress;

  StartExercise(
    this.name,
    this.description,
    this.count,
    this.time,
    this.onStartPress,
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String noun = fixNoun(count, 'powtórze', 'nie', 'nia', 'ń');
    return Container(
      width: size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey[200],
      ),
      child: Column(
        children: <Widget>[
          BigText(name),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SmallText('$count $noun'),
              Text('•'),
              SmallText(secondsToHMS(time)),
            ],
          ),
          SmallText(description),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              NavigationButton(
                'Poprzednie',
                () {},
              ),
              StartButton(
                'Rozpocznij',
                onStartPress,
              ),
              NavigationButton(
                'Następne',
                () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
