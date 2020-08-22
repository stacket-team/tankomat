// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class MapView extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapView> {
  Widget _webcamWidget;
  VideoElement _webcamVideoElement;

  @override
  void initState() {
    super.initState();

    _webcamVideoElement = VideoElement();

    // This error occures because of IDE, ignore it (works in build)
    ui.platformViewRegistry.registerViewFactory(
      'webcamVideoElement',
      (int viewId) => _webcamVideoElement,
    );

    _webcamWidget =
        HtmlElementView(key: UniqueKey(), viewType: 'webcamVideoElement');

    window.navigator.getUserMedia(video: true).then((MediaStream stream) {
      _webcamVideoElement.srcObject = stream;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text('Mapa'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Webcam MediaStream',
              style: TextStyle(fontSize: 30.0),
            ),
            Container(
              width: 750.0,
              height: 750.0,
              child: _webcamWidget,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Start stream, stop stream',
        child: Icon(Icons.camera_alt),
        onPressed: () {
          _webcamVideoElement.srcObject.active
              ? _webcamVideoElement.play()
              : _webcamVideoElement.pause();
        },
      ),
    );
  }
}
