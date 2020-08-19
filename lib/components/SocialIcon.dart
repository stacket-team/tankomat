import 'package:flutter/material.dart';
import 'package:tankomat/constants.dart';
import '../constants.dart';

class SocialIcon extends StatelessWidget {
  final String iconSrc;
  final Function press;
  const SocialIcon({
    Key key,
    this.iconSrc,
    this.press,
  }) : super(key: key);

  @override
  build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: PRIMARY_COLOR),
          shape: BoxShape.circle,
        ),
        child: Image(
          image: AssetImage(iconSrc),
        ),
      ),
    );
  }
}
