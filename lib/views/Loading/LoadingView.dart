import 'package:flutter/material.dart';
import 'package:tankomat/views/Loading/components/Body.dart';
import 'package:tankomat/utils.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initializeAuth(context);
    return Scaffold(
      body: Body(),
    );
  }
}
