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

  int id;
  String name;
  List elements;
  int totalTime;
  bool isLoaded = false;

  int exerciseID = 0;
  bool started = false;
  int time;
  DateTime timestamp;
  DateTime startTimestamp;
  Timer timer;

  _TrainingState(this.user, this.arguments) {
    if (arguments != null && arguments.containsKey('id')) {
      id = arguments['id'];
      name = arguments.containsKey('name') ? arguments['name'] : '';
      getTraining();
    }
  }

  @override
  void dispose() {
    if (timer != null) timer.cancel();
    super.dispose();
  }

  void getTraining() async {
    firestore.DocumentSnapshot snapshot = await user.ref.get();
    Map training = snapshot.get('trainings')[id];
    setState(() {
      name = training['name'];
      elements = training['elements'];
      totalTime = training['totalTime'];
      isLoaded = true;
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

    setState(() {
      started = true;
      time = 0;
      timestamp = _timestamp;
      startTimestamp = _startTimestamp;
      timer = _timer;
    });
  }

  void endExercise() {
    timer.cancel();
    int _exerciseID = exerciseID + 1;

    if (_exerciseID < elements.length) {
      setState(() {
        started = false;
        exerciseID = _exerciseID;
        // TODO Add pause display
      });
    } else {
      Navigator.of(context).pushNamed(
        '/finished',
        arguments: {
          'id': id,
          'start': startTimestamp,
          'end': DateTime.now(),
          // TODO Add metrics
        },
      );
    }
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
      appBar: AppBar(
        title: Text(name),
      ),
      body: Body(
        isLoaded: isLoaded,
        started: started,
        current: elements != null ? elements[exerciseID] : {},
        onStartPress: startExercise,
        onEndPress: endExercise,
        time: time,
      ),
    );
  }
}
