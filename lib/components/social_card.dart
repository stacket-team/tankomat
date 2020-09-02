import 'package:flutter/material.dart';

class SocialCard extends StatelessWidget {
  final String icon;
  final Function onPress;

  const SocialCard({
    Key key,
    this.icon,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        padding: EdgeInsets.all(12.0),
        height: 50.0,
        width: 50.0,
        decoration: BoxDecoration(
          color: Color(0xFFF5F6F9),
          shape: BoxShape.circle,
        ),
        child: Image(
          image: AssetImage(icon),
        ),
      ),
    );
  }
}
