import 'package:flutter/material.dart';
import 'package:tankomat/components/HorizontalScroll.dart';

class DashboardView extends StatefulWidget {
  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('dashboard'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: size.height * 0.3,
            margin: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 25.0),
            child: HorizontalScroll(),
          ),
        ],
      ),
    );
  }
}
