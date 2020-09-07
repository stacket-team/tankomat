import 'package:flutter/material.dart';
import 'package:tankomat/constants.dart';

class GroupFloatingActionButton extends StatelessWidget {
  final Function onPress;
  final bool show;

  GroupFloatingActionButton(this.onPress, this.show);

  @override
  Widget build(BuildContext context) {
    return show
        ? FloatingActionButton(
            onPressed: onPress,
            child: Icon(Icons.repeat),
            backgroundColor: PRIMARY_COLOR,
          )
        : Container();
  }
}
