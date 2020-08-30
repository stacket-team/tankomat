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
  final bool paused;
  final int leftPauseTime;
  final bool runAfterPause;
  final Function toggleRunAfterPause;

  StartExercise(
    this.name,
    this.description,
    this.count,
    this.time,
    this.onStartPress,
    this.paused,
    this.leftPauseTime,
    this.runAfterPause,
    this.toggleRunAfterPause,
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
          paused
              ? Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.alarm),
                        SmallText(secondsToHMS(leftPauseTime)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Checkbox(
                          value: runAfterPause,
                          onChanged: toggleRunAfterPause,
                        ),
                        SmallText('Uruchom po przerwie'),
                      ],
                    ),
                  ],
                )
              : Container(),
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
