import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tankomat/views/Training/components/Body.dart';
import 'package:tankomat/utils.dart' show User;
import 'package:firebase/firestore.dart' as firestore;

class TrainingView extends StatefulWidget {
  final User user;
  final Map arguments;

  TrainingView(this.user, this.arguments);

  @override
  _TrainingState createState() => _TrainingState(user, this.arguments);
}

class _TrainingState extends State<TrainingView> {
  final User user;
  final Map arguments;
  final List<Map<String, dynamic>> metrics = [];

  int id;
  String name;
  List elements;
  int totalTime;
  int rest;

  int exerciseID = 0;
  bool started = false;
  int time = 0;
  DateTime timestamp;
  DateTime startTimestamp;
  Timer timer;

  bool paused = false;
  DateTime pauseTimestamp;
  int pauseTime = 0;
  Timer pauseTimer;
  bool runAfterPause;

  _TrainingState(this.user, this.arguments) {
    if (arguments != null && arguments.containsKey('id')) {
      id = arguments['id'];
      name = arguments.containsKey('name') ? arguments['name'] : '';
      runAfterPause = user.runAfterPause;
      getTraining();
    }
  }

  @override
  void dispose() {
    if (timer != null) timer.cancel();
    if (pauseTimer != null) pauseTimer.cancel();
    super.dispose();
  }

  void getTraining() async {
    firestore.DocumentSnapshot snapshot = await user.ref.get();
    Map training = snapshot.get('trainings')[id];
    setState(() {
      name = training['name'];
      elements = training['elements'];
      totalTime = training['totalTime'];
      rest = training['rest'];
    });
  }

  void startExercise() {
    DateTime _timestamp = DateTime.now();
    DateTime _startTimestamp =
        startTimestamp == null ? DateTime.now() : startTimestamp;
    Timer _timer = Timer.periodic(
      Duration(seconds: 1),
      (_) {
        setState(() {
          time = DateTime.now().difference(timestamp).inSeconds;
        });
      },
    );

    if (pauseTimer != null) {
      pauseTimer.cancel();
      metrics.add(User.createMetricForPause(
        rest,
        pauseTime + 1,
        exerciseID - 1,
      ));
    }

    setState(() {
      started = true;
      time = 0;
      timestamp = _timestamp;
      startTimestamp = _startTimestamp;
      timer = _timer;
      pauseTime = 0;
    });
  }

  void endExercise() {
    timer.cancel();
    int _exerciseID = exerciseID + 1;

    metrics.add(User.createMetricForExercise(
      elements[exerciseID]['name'],
      int.parse(elements[exerciseID]['count']),
      elements[exerciseID]['time'],
      time,
    ));

    if (_exerciseID < elements.length) {
      DateTime _pauseTimestamp = DateTime.now();
      Timer _pauseTimer = Timer.periodic(
        Duration(seconds: 1),
        (_) {
          int _pauseTime = DateTime.now().difference(pauseTimestamp).inSeconds;
          if (_pauseTime >= rest && runAfterPause) {
            pauseTimer.cancel();
            startExercise();
          } else {
            setState(() {
              paused = _pauseTime < rest;
              pauseTime = _pauseTime;
            });
          }
        },
      );
      setState(() {
        started = false;
        exerciseID = _exerciseID;
        paused = true;
        pauseTimestamp = _pauseTimestamp;
        pauseTimer = _pauseTimer;
      });
    } else {
      Navigator.of(context).pushNamed(
        '/finished',
        arguments: {
          'id': id,
          'name': name,
          'start': startTimestamp,
          'end': DateTime.now(),
          'metrics': metrics,
        },
      );
    }
  }

  void toggleRunAfterPause(bool value) {
    user.ref.update(
      data: {
        'runAfterPause': value,
      },
    );
    setState(() {
      runAfterPause = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (id == null) {
      Navigator.of(context).pushNamed(
        '/',
        arguments: {
          'tab': 1,
        },
      );
    }

    return Scaffold(
      appBar: timer == null
          ? AppBar(
              title: Text(name),
            )
          : AppBar(
              title: Text(name),
              leading: Container(),
            ),
      body: Body(
        started: started,
        paused: paused,
        leftPauseTime: rest != null ? rest - pauseTime : pauseTime,
        runAfterPause: runAfterPause,
        toggleRunAfterPause: toggleRunAfterPause,
        current: elements != null ? elements[exerciseID] : null,
        onStartPress: startExercise,
        onEndPress: endExercise,
        time: time,
      ),
    );
  }
}
