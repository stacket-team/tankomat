import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tankomat/views/AddTraining/components/Body.dart';
import 'package:tankomat/utils.dart' show User, fixZeros, parseTime;
import 'package:firebase/firestore.dart' as firestore;
import 'package:tankomat/views/AddTraining/components/FloatingMenu.dart';

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
  List<Map<String, dynamic>> controllers = [];
  List<List<int>> selectedCards = [];

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

  List<Map<String, dynamic>> createControllers(elements, List<int> offset) {
    List<Map<String, dynamic>> controllers = [];
    (elements as List).asMap().forEach((id, element) {
      Map<String, dynamic> group = {};
      List<int> chain = [id];
      chain.insertAll(0, offset);
      (element as Map).forEach((key, value) {
        if (key == 'elements') {
          group[key] = createControllers(value, chain);
        } else if (key != 'time') {
          group[key] = TextEditingController(
              text: value is num ? value.toString() : value);
          group[key].addListener(onFieldChange(chain, key, group[key]));
        }
      });
      controllers.add(group);
    });
    return controllers;
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

    List<Map<String, dynamic>> _controllers = createControllers(_elements, []);

    List<int> _times = [
      1,
      1,
      1
    ]; //_elements.map((e) => e['time'] as int).toList();
    int _totalTime = _times.reduce((acc, element) => acc + element);

    setState(() {
      elements = _elements;
      controllers = _controllers;
      times = _times;
      totalTime = _totalTime;
      saveText = _saveText;
      saveColor = Colors.green;
      selectedCards = [];
    });
  }

  Function onCardMoved(List<int> to) => () async {
        // TODO Fix the out of range error
        // TODO Unable to move card if the card is first (in all or in group)
        List newElements = elements;
        List removedElements = [];
        selectedCards.sort((a, b) => b.join(',').compareTo(a.join(',')));

        // delete old elements
        List<Map<String, List>> editedGroups = [];
        for (List<int> chain in selectedCards) {
          Map selectedElement = newElements[chain.first];
          List temp;
          List parent = newElements;
          chain.skip(1).forEach((id) {
            temp = parent;
            parent = selectedElement['elements'];
            selectedElement = parent[id];
          });
          if (chain.length > 1) {
            editedGroups.add({
              'chain': chain,
              'group': parent,
              'parent': temp,
            });
          }
          removedElements.add(parent.removeAt(chain.last));
        }

        // insert new group
        Map selectedElement = newElements.asMap().containsKey(to.first)
            ? newElements[to.first]
            : null;
        List parent = newElements;
        to.skip(1).forEach((id) {
          parent = selectedElement['elements'];
          if (id < parent.length) selectedElement = parent[id];
        });
        parent.insertAll(to.last, removedElements);

        // if chain before is now empty, delete it
        Map<int, List<int>> removedPositions = {};
        for (Map<String, List> groupData in editedGroups) {
          if (groupData['group'].isEmpty) {
            int removedPositionID = groupData['chain'].length - 2;
            int removedPosition = groupData['chain'][removedPositionID];
            bool remove = false;
            if (removedPositions.containsKey(removedPositionID)) {
              remove = removedPositions[removedPositionID]
                      .contains(removedPosition) ==
                  false;
            } else {
              removedPositions[removedPositionID] = [removedPosition];
              remove = true;
            }
            if (remove) {
              groupData['parent'].removeAt(removedPosition);
            }
          }
        }

        await user.ref.update(
          data: {
            'draft.timestamp': firestore.FieldValue.serverTimestamp(),
            'draft.elements': newElements,
          },
        );
        getDraft();
      };

  List<List<int>> getChainsOf(List elements, List<int> chain) {
    List<List<int>> chains = [];
    for (MapEntry<int, dynamic> entry in elements.asMap().entries) {
      Map element = entry.value as Map;
      List<int> elementChain = [entry.key];
      elementChain.insertAll(0, chain);
      chains.add(elementChain);
      if (element.containsKey('elements')) {
        chains.addAll(getChainsOf(element['elements'], elementChain));
      }
    }
    return chains;
  }

  Function toggleCardSelection(List<int> cardID) => (bool _) {
        List<List<int>> _selectedCards = selectedCards;
        Iterable<String> mappedCards =
            _selectedCards.map((chain) => chain.join(','));
        if (mappedCards.contains(cardID.join(','))) {
          _selectedCards
              .removeWhere((chain) => chain.join(',') == cardID.join(','));
        } else {
          bool isParentNotSelected = true;
          List<int> parentChain = [];
          List parent = elements;
          int lastID = cardID.first;
          Map element = parent[lastID];
          cardID.skip(1).forEach((id) {
            parentChain.add(lastID);
            parent = element['elements'];
            if (isParentNotSelected &&
                mappedCards.contains(parentChain.join(','))) {
              isParentNotSelected = false;
            }
            lastID = id;
            element = parent[lastID];
          });

          if (isParentNotSelected) {
            if (element.containsKey('elements')) {
              Iterable<String> chains = getChainsOf(element['elements'], cardID)
                  .map((chain) => chain.join(','));
              _selectedCards
                  .removeWhere((chain) => chains.contains(chain.join(',')));
            }
            _selectedCards.add(cardID);
          }
        }
        setState(() {
          selectedCards = _selectedCards;
        });
      };

  Function onFieldChange(
    List<int> chain,
    String key,
    TextEditingController controller,
  ) =>
      () {
        Map element = elements[chain.first];
        chain.skip(1).forEach((id) {
          element = element['elements'][id];
        });
        if (element[key] != controller.text) {
          setState(() {
            element[key] = controller.text;
            if (key == 'duration') {
              element['time'] = parseTime(controller.text);
              // TODO recalc time
              // times = elements.map((e) => e['time'] as int).toList();
              // totalTime = times.reduce((acc, time) => acc + time);
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
            0, // TODO Add propper input for this value
          ),
        ]),
      },
    );
    Navigator.of(context).pushNamed(
      '/',
      arguments: {
        'tab': 1,
      },
    );
  }

  void addGroup() async {
    List newElements = elements;
    List groupElements = [];
    selectedCards.sort((a, b) => b.join(',').compareTo(a.join(',')));

    // determine where to insert the new group
    List<int> insertAt;
    int minDepth = double.maxFinite as int;
    bool same = true;
    for (List<int> chain in selectedCards) {
      if (chain.length < minDepth) {
        minDepth = chain.length;
        insertAt = chain;
      }
      if (chain.length != minDepth) {
        same = false;
      }
    }
    if (same) {
      insertAt = selectedCards.last;
    }

    // delete old elements
    List<Map<String, List>> editedGroups = [];
    for (List<int> chain in selectedCards) {
      Map selectedElement = newElements[chain.first];
      List temp;
      List parent = newElements;
      chain.skip(1).forEach((id) {
        temp = parent;
        parent = selectedElement['elements'];
        selectedElement = parent[id];
      });
      if (chain.length > 1) {
        editedGroups.add({
          'chain': chain,
          'group': parent,
          'parent': temp,
        });
      }
      groupElements.add(parent.removeAt(chain.last));
    }

    // insert new group
    Map selectedElement = newElements.asMap().containsKey(insertAt.first)
        ? newElements[insertAt.first]
        : null;
    List parent = newElements;
    insertAt.skip(1).forEach((id) {
      parent = selectedElement['elements'];
      if (id < parent.length) selectedElement = parent[id];
    });
    parent.insert(insertAt.last, User.createGroup(groupElements));

    // if chain before is now empty, delete it
    Map<int, List<int>> removedPositions = {};
    for (Map<String, List> groupData in editedGroups) {
      if (groupData['group'].isEmpty) {
        int removedPositionID = groupData['chain'].length - 2;
        int removedPosition = groupData['chain'][removedPositionID];
        bool remove = false;
        if (removedPositions.containsKey(removedPositionID)) {
          remove =
              removedPositions[removedPositionID].contains(removedPosition) ==
                  false;
        } else {
          removedPositions[removedPositionID] = [removedPosition];
          remove = true;
        }
        if (remove) {
          groupData['parent'].removeAt(removedPosition);
        }
      }
    }

    await user.ref.update(
      data: {
        'draft.timestamp': firestore.FieldValue.serverTimestamp(),
        'draft.elements': newElements,
      },
    );
    getDraft();
  }

  void removeSelected() async {
    // TODO When removing a group ask if user wants to keep it contents

    List newElements = elements;
    selectedCards.sort((a, b) => b.join(',').compareTo(a.join(',')));

    // delete selected elements
    List<Map<String, List>> editedGroups = [];
    for (List<int> chain in selectedCards) {
      Map selectedElement = newElements[chain.first];
      List temp;
      List parent = newElements;
      chain.skip(1).forEach((id) {
        temp = parent;
        parent = selectedElement['elements'];
        selectedElement = parent[id];
      });
      if (chain.length > 1) {
        editedGroups.add({
          'chain': chain,
          'group': parent,
          'parent': temp,
        });
      }
      parent.removeAt(chain.last);
    }

    // if chain before is now empty, delete it
    Map<int, List<int>> removedPositions = {};
    for (Map<String, List> groupData in editedGroups) {
      if (groupData['group'].isEmpty) {
        int removedPositionID = groupData['chain'].length - 2;
        int removedPosition = groupData['chain'][removedPositionID];
        bool remove = false;
        if (removedPositions.containsKey(removedPositionID)) {
          remove =
              removedPositions[removedPositionID].contains(removedPosition) ==
                  false;
        } else {
          removedPositions[removedPositionID] = [removedPosition];
          remove = true;
        }
        if (remove) {
          groupData['parent'].removeAt(removedPosition);
        }
      }
    }

    await user.ref.update(
      data: {
        'draft.timestamp': firestore.FieldValue.serverTimestamp(),
        'draft.elements': newElements,
      },
    );
    getDraft();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingMenu(
        selectedCards.length,
        addGroup,
        removeSelected,
      ),
      body: Body(
        saveText: saveText,
        saveColor: saveColor,
        nameController: nameController,
        controllers: controllers,
        times: times,
        totalTime: totalTime,
        onCardMoved: onCardMoved,
        toggleCardSelection: toggleCardSelection,
        isCardMoving: selectedCards.length == 1,
        selectedCardID: selectedCards.length == 1 ? selectedCards.first : null,
        isCardSelected: selectedCards.length > 0,
        selectedCardsID: selectedCards,
        onAddFieldPress: addCard,
        onSubmitPress: submitTraining,
      ),
    );
  }
}
