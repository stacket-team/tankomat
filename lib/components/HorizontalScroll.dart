import 'package:flutter/material.dart';

class HorizontalScroll extends StatefulWidget {
  @override
  _HorizontalScrollState createState() => _HorizontalScrollState();
}

class _HorizontalScrollState extends State<HorizontalScroll> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.2,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          ScrollTile(),
          ScrollTile(),
          ScrollTile(),
          ScrollTile(),
          ScrollTile(),
        ],
      ),
    );
  }
}

class ScrollTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 3),
      width: MediaQuery.of(context).size.width * (6 / 18) - 20,
      height: MediaQuery.of(context).size.width * 0.3,
      margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.013),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.green,
      ),
    );
  }
}
