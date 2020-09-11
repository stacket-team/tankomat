import 'package:flutter/material.dart';

class Group extends StatelessWidget {
  final TextEditingController countController;
  final Widget firstTarget;
  final List<Widget> elements;

  Group(this.countController, this.firstTarget, this.elements);

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [firstTarget];
    children.addAll(elements);

    // TODO Add a count input and a custom painter
    return Container(
      child: Column(
        children: children,
      ),
    );
  }
}
