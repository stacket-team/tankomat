import 'package:flutter/material.dart';
import 'package:tankomat/constants.dart';
import 'package:tankomat/utils.dart' show fixNoun;

class Group extends StatelessWidget {
  final List<int> chain;
  final TextEditingController countController;
  final Widget firstTarget;
  final List<Widget> elements;
  final Function toggleCardSelection;
  final List<List<int>> selectedCardsID;
  final bool isCardSelected;

  Group(
    this.chain,
    this.countController,
    this.firstTarget,
    this.elements,
    this.toggleCardSelection,
    this.selectedCardsID,
    this.isCardSelected,
  );

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [firstTarget];
    children.addAll(elements);

    int parsed = int.tryParse(countController.text);
    String noun = parsed != null
        ? fixNoun(parsed, 'powtórze', 'nie', 'nia', 'ń')
        : parsed;

    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 0, 20),
      child: CustomPaint(
        painter: GroupBackground(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Checkbox(
                  value: selectedCardsID
                      .map((selectedChain) => selectedChain.join(','))
                      .contains(chain.join(',')),
                  onChanged: toggleCardSelection(chain),
                ),
                isCardSelected
                    ? Text(
                        (countController.text.isEmpty || parsed == null)
                            ? 'Grupa ćwiczeń'
                            : '${countController.text} $noun',
                      )
                    : SizedBox(
                        width: 200,
                        child: TextField(
                          controller: countController,
                          decoration: InputDecoration(
                            hintText: 'Ilość potwórzeń',
                          ),
                        ),
                      ),
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(30, 0, 0, 30),
              child: Column(
                children: children,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GroupBackground extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double w = 180;
    double big = 60, full = big / 2, half = full / 2;

    Path path = Path();
    path.addRect(Rect.fromLTWH(full, 0, w, big));
    path.addRect(Rect.fromLTWH(0, full, full, size.height - full - half));
    path.addRect(Rect.fromLTWH(half, size.height - full, w + half, full));

    path.addOval(Rect.fromLTWH(0, 0, big, big));
    path.addOval(Rect.fromLTWH(w, 0, big, big));
    path.addOval(Rect.fromLTWH(0, size.height - full, full, full));
    path.addOval(Rect.fromLTWH(w + half, size.height - full, full, full));

    canvas.drawPath(
      path,
      Paint()..color = PRIMARY_COLOR,
    );
  }

  @override
  bool shouldRepaint(GroupBackground old) => false;
}
