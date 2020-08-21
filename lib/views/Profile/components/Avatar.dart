import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final Function onPress;
  final String url;

  Avatar({
    this.onPress,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPress,
      padding: EdgeInsets.all(10.0),
      child: url != null
          ? Image.network(
              url,
              width: 120,
              height: 120,
              isAntiAlias: true,
            )
          : Image(
              image: AssetImage('avatar.png'),
              width: 120,
              height: 120,
              isAntiAlias: true,
            ),
    );
  }
}
