import 'package:flutter/material.dart';

class Provider extends StatelessWidget {
  final Function onPress;
  final String imageSrc;
  final String name;

  Provider({
    this.onPress,
    this.imageSrc,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPress,
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          Image(
            image: AssetImage(imageSrc),
            width: 32,
            height: 32,
            isAntiAlias: true,
          ),
          Text(name),
        ],
      ),
    );
  }
}
