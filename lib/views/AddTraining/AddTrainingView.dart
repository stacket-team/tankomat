import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tankomat/views/AddTraining/components/Body.dart';
import 'package:tankomat/utils.dart' show User, fixZeros, parseTime;
import 'package:firebase/firestore.dart' as firestore;

class AddTrainingView extends StatefulWidget {
  final User user;

  AddTrainingView(this.user);

  @override
  _AddTrainingState createState() => _AddTrainingState(user);
}

class _AddTrainingState extends State<AddTrainingView> {
  final User user;
  final TextEditingController nameController = TextEditingController();
  Timer timer;
  Color saveColor = Colors.green;
  String saveText = '';
  bool doSave = false;
  List<dynamic> elements = [];
  List<int> times = [];
  int totalTime = 0;
  List<Map<String, TextEditingController>> controllers = [];
  int movingCardID;

  _AddTrainingState(this.user) {
    timer = Timer.periodic(
      Duration(seconds: 15), // TODO Run 15 seconds after stopped writing
      (_) async {
        if (doSave) {
          await user.ref.update(
            data: {
              'draft.timestamp': firestore.FieldValue.serverTimestamp(),
              'draft.elements': elements,
            },
          );
          getDraft();
        }
      },
    );
    getDraft();
    // user.ref.onSnapshot.listen((firestore.DocumentSnapshot snapshot) {});
  }

  @override
  void dispose() {
    timer.cancel();
    nameController.dispose();
    for (Map<String, TextEditingController> group in controllers) {
      for (TextEditingController controller in group.values) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  void getDraft() async {
    firestore.DocumentSnapshot snapshot = await user.ref.get();
    final draft = snapshot.get('draft');

    String _saveText = 'Ostatni zapis ';
    DateTime time = draft['timestamp'];
    DateTime now = DateTime.now();
    bool isToday = DateTime(time.year, time.month, time.day) ==
        DateTime(now.year, now.month, now.day);
    String hour = fixZeros(time.hour);
    String minute = fixZeros(time.minute);
    String day = fixZeros(time.day);
    String month = fixZeros(time.month);
    String year = fixZeros(time.year);
    _saveText += isToday ? '$hour:$minute' : '$day.$month.$year $hour:$minute';

    List<dynamic> _elements = draft['elements'];

    List<Map<String, TextEditingController>> _controllers = [];
    _elements.asMap().forEach((id, element) {
      Map<String, TextEditingController> map = {
        'name': TextEditingController(text: element['name']),
        'description': TextEditingController(text: element['description']),
        'count': TextEditingController(text: element['count'].toString()),
        'duration': TextEditingController(text: element['duration']),
      };

      map.forEach((key, controller) {
        controller.addListener(onFieldChange(id, key, controller));
      });

      _controllers.add(map);
    });

    List<int> _times = _elements.map((e) => e['time'] as int).toList();
    int _totalTime = _times.reduce((acc, element) => acc + element);

    setState(() {
      elements = _elements;
      controllers = _controllers;
      times = _times;
      totalTime = _totalTime;
      saveText = _saveText;
      saveColor = Colors.green;
    });
  }

  void onCardMoved(int from, int to) async {
    final element = elements[from];
    elements.removeAt(from);
    if (from < to) to -= 1;
    elements.insert(to, element);
    await user.ref.update(
      data: {
        'draft.timestamp': firestore.FieldValue.serverTimestamp(),
        'draft.elements': elements,
      },
    );
    getDraft();
  }

  void showTargets(int cardID) {
    setState(() {
      movingCardID = cardID;
    });
  }

  void hideTargets() {
    setState(() {
      movingCardID = null;
    });
  }

  Function onFieldChange(
          int id, String key, TextEditingController controller) =>
      () {
        if (elements[id][key] != controller.text) {
          setState(() {
            elements[id][key] = controller.text;
            if (key == 'duration') {
              elements[id]['time'] = parseTime(controller.text);
              times = elements.map((e) => e['time'] as int).toList();
              totalTime = times.reduce((acc, element) => acc + element);
            }
            saveText = '';
            saveColor = Colors.grey;
            doSave = true;
          });
        }
      };

  void addCard() async {
    List newElements = elements;
    newElements.add(User.createEmptyExercise());
    await user.ref.update(
      data: {
        'draft.timestamp': firestore.FieldValue.serverTimestamp(),
        'draft.elements': newElements,
      },
    );
    getDraft();
  }

  void submitTraining() async {
    String name = nameController.text.trim();
    await user.ref.update(
      data: {
        'draft': User.createEmptyDraft(),
        'trainings': firestore.FieldValue.arrayUnion([
          User.createTraining(
            name.isEmpty ? 'Nowy trening' : name,
            elements,
            totalTime,
          ),
        ]),
      },
    );
    Navigator.of(context).pushNamed('/trainings');
  }

//   void submitTraining() async {
//     String name = nameController.text.trim();
//     firestore.DocumentSnapshot snapshot = await user.ref.get();
//     List trainings = snapshot.get('trainings');
//     trainings.add(User.createTraining(
//       name.isEmpty ? 'Nowy trening' : name,
//       elements,
//       totalTime,
//     ));
//     await user.ref.update(
//       data: {
//         'draft': User.createEmptyDraft(),
//         'trainings': trainings,
//       },
//     );
//     Navigator.of(context).pushNamed('/trainings');
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        saveText: saveText,
        saveColor: saveColor,
        nameController: nameController,
        controllers: controllers,
        times: times,
        totalTime: totalTime,
        onCardMoved: onCardMoved,
        showTargets: showTargets,
        hideTargets: hideTargets,
        isCardMoving: movingCardID != null,
        movingCardID: movingCardID,
        onAddFieldPress: addCard,
        onSubmitPress: submitTraining,
      ),
    );
  }
}
