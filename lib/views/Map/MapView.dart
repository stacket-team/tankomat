import 'package:flutter/material.dart';

class MapView extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
      ),
    );
  }
}
