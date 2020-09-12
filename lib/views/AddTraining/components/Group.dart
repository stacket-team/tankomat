import 'package:flutter/material.dart';
import 'package:tankomat/constants.dart';

class Group extends StatelessWidget {
  final TextEditingController countController;
  final Widget firstTarget;
  final List<Widget> elements;

  Group(this.countController, this.firstTarget, this.elements);

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [firstTarget];
    children.addAll(elements);

    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 0, 20),
      child: CustomPaint(
        painter: GroupBackground(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 200,
              child: TextField(
                controller: countController,
                decoration: InputDecoration(
                  hintText: 'Ilość powtórzeń',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(60, 30, 0, 20),
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
    double big = 60, full = big / 2, half = full / 2;
    Path path = Path();
    path.addRect(Rect.fromLTWH(full, 0, 150, big));
    path.addRect(Rect.fromLTWH(full, full, size.width / 2, full));
    path.addRect(Rect.fromLTWH(0, full, full, size.height - full - half));
    path.addRect(
        Rect.fromLTWH(half, size.height - full, size.width / 2 + half, full));

    path.addOval(Rect.fromLTWH(0, 0, big, big));
    path.addOval(Rect.fromLTWH(140, 0, big, big));
    path.addOval(Rect.fromLTWH(0, size.height - full, full, full));
    path.addOval(
        Rect.fromLTWH(size.width / 2 + half, size.height - full, full, full));
    path.addOval(Rect.fromLTWH(size.width / 2 + half, full, full, full));

    canvas.drawPath(
      path,
      Paint()..color = PRIMARY_COLOR,
    );
  }

  @override
  bool shouldRepaint(GroupBackground old) => false;
}
