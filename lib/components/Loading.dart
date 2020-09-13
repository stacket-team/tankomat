import 'package:flutter/material.dart';
import 'package:tankomat/constants.dart';

class Loading extends StatelessWidget {
  final double size;
  final double width;
  final Color color;

  Loading({
    this.size = 50.0,
    this.width = 4.0,
    this.color = PRIMARY_COLOR,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(color),
        strokeWidth: width,
        value: null,
      ),
    );
  }
}
