import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tankomat/views/AddTraining/components/Body.dart';
import 'package:tankomat/utils.dart' show User;
import 'package:firebase/firestore.dart' as firestore;

class AddTrainingView extends StatefulWidget {
  final User user;

  AddTrainingView(this.user);

  @override
  _AddTrainingState createState() => _AddTrainingState(user);
}

class _AddTrainingState extends State<AddTrainingView> {
  final User user;
  Timer timer;
  Color saveColor = Colors.green;
  String saveText = '';
  bool doSave = false;
  List<dynamic> elements = [];
  List<Map<String, TextEditingController>> controllers = [];
  int lastID;

  _AddTrainingState(this.user) {
    timer = Timer.periodic(
      Duration(seconds: 15),
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
    for (Map<String, TextEditingController> group in controllers) {
      for (TextEditingController controller in group.values) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  String fixZeros(int number) {
    return number < 10 ? '0' + number.toString() : number.toString();
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

    int _lastID = draft['lastID'];

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

    setState(() {
      lastID = _lastID;
      elements = _elements;
      controllers = _controllers;
      saveText = _saveText;
      saveColor = Colors.green;
    });
  }

  Function onFieldChange(
          int id, String key, TextEditingController controller) =>
      () {
        if (elements[id][key] != controller.text) {
          setState(() {
            elements[id][key] = controller.text;
            saveText = '';
            saveColor = Colors.grey;
            doSave = true;
          });
        }
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        saveText: saveText,
        saveColor: saveColor,
        controllers: controllers,
        onAddFieldPress: () async {
          int newID = lastID + 1;
          List newElements = elements;
          newElements.add({
            'id': newID,
            'name': '',
            'description': '',
            'count': 5,
            'duration': '15 sek',
          });
          await user.ref.update(
            data: {
              'draft.timestamp': firestore.FieldValue.serverTimestamp(),
              'draft.elements': newElements,
              'draft.lastID': newID,
            },
          );
          getDraft();
        },
      ),
    );
  }
}
