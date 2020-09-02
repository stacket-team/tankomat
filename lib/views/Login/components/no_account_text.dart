import 'package:flutter/material.dart';
import 'package:tankomat/constants.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Nie masz konta? ',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.of(context).pushNamed('/forgotPassword'),
          child: Text(
            'Zarejestruj się!',
            style: TextStyle(
              fontSize: 16.0,
              color: PRIMARY_COLOR,
            ),
          ),
        ),
      ],
    );
  }
}
