import 'package:flutter/material.dart';

class Group extends StatelessWidget {
  final List<Widget> elements;
  final TextEditingController countController;

  Group(this.countController, this.elements);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: elements,
      ),
    );
  }
}
