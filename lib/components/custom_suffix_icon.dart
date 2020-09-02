import 'package:flutter/material.dart';

class CustomSuffixIcon extends StatelessWidget {
  final IconData iconName;

  const CustomSuffixIcon({
    Key key,
    @required this.iconName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20.0, 20.0, 20.0),
      child: Icon(iconName),
    );
  }
}
