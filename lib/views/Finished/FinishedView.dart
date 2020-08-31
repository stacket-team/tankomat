import 'package:flutter/material.dart';
import 'package:tankomat/views/Finished/components/Body.dart';
import 'package:tankomat/utils.dart' show User;
import 'package:firebase/firestore.dart' as firestore;

class FinishedView extends StatelessWidget {
  final User user;
  final Map arguments;

  final int id;
  final String name;
  final DateTime start;
  final DateTime end;
  final List<Map<String, dynamic>> metrics;

  FinishedView(this.user, this.arguments)
      : id = arguments.containsKey('id') ? arguments['id'] : null,
        name = arguments.containsKey('name') ? arguments['name'] : '',
        start = arguments.containsKey('start') ? arguments['start'] : null,
        end = arguments.containsKey('end') ? arguments['end'] : null,
        metrics = arguments.containsKey('metrics') ? arguments['metrics'] : [];

  void navigateToTrainings(BuildContext context) {
    Navigator.of(context).pushNamed(
      '/',
      arguments: {
        'tab': 1,
      },
    );
  }

  Function saveTraining(BuildContext context) => () async {
        firestore.DocumentSnapshot snapshot = await user.ref.get();
        List history = snapshot.get('history');
        history.add(User.createPieceOfHistory(
          id,
          name,
          start,
          end,
          metrics,
        ));

        await user.ref.update(
          data: {
            'history': history,
          },
        );

        navigateToTrainings(context);
      };

  Function discardTraining(BuildContext context) => () {
        // TODO Add to discarded for 30 days
        navigateToTrainings(context);
      };

  @override
  Widget build(BuildContext context) {
    if (id == null) navigateToTrainings(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        leading: Container(),
      ),
      body: Body(
        onSave: saveTraining(context),
        onDiscard: discardTraining(context),
      ),
    );
  }
}
