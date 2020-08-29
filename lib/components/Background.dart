import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  final backgroundColor;

  const Background({
    this.backgroundColor,
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        height: size.height,
        width: size.width,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            child,
          ],
        ),
      ),
    );
  }
}
