import 'package:flutter/material.dart';
import 'package:tankomat/views/Trainings/components/Body.dart';
import 'package:tankomat/utils.dart' show User;
import 'package:firebase/firestore.dart' as firestore;

class TrainingsView extends StatefulWidget {
  final User user;

  TrainingsView(this.user);

  @override
  _TrainingsState createState() => _TrainingsState(user);
}

class _TrainingsState extends State<TrainingsView> {
  final User user;
  List trainings = [];

  _TrainingsState(this.user) {
    getTrainings();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getTrainings() async {
    firestore.DocumentSnapshot snapshot = await user.ref.get();
    setState(() {
      trainings = snapshot.get('trainings');
    });
  }

  void redirectToAddTraining() {
    Navigator.of(context).pushNamed('/add');
  }

  void showCardMenu(int id) => () async {
        Function fn = await showMenu<Function>(
          context: context,
          position: RelativeRect.fromLTRB(0, 0, 0, 0), // TODO Fix position
          items: [
            PopupMenuItem(
              value: () {
                Navigator.of(context).pushNamed(
                  '/edit',
                  arguments: {
                    'id': id,
                  },
                );
              },
              child: Text("Edytuj"),
            ),
            PopupMenuItem(
              value: () {
                Navigator.of(context).pushNamed(
                  '/delete',
                  arguments: {
                    'id': id,
                  },
                );
              },
              child: Text("Usuń"),
            ),
          ],
        );
        if (fn != null) fn();
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        trainings: trainings,
        onAddTrainingPress: redirectToAddTraining,
        onLongCardPress: showCardMenu,
      ),
    );
  }
}
