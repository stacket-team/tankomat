import 'package:flutter/material.dart';
import 'package:tankomat/route_generator.dart';
import 'package:tankomat/utils.dart';

void main() {
  initializeFirebase();
  runApp(MyApp());
}

Map<int, Color> colorCodes = {
  50: Color.fromRGBO(147, 205, 72, .1),
  100: Color.fromRGBO(147, 205, 72, .2),
  200: Color.fromRGBO(147, 205, 72, .3),
  300: Color.fromRGBO(147, 205, 72, .4),
  400: Color.fromRGBO(147, 205, 72, .5),
  500: Color.fromRGBO(147, 205, 72, .6),
  600: Color.fromRGBO(147, 205, 72, .7),
  700: Color.fromRGBO(147, 205, 72, .8),
  800: Color.fromRGBO(147, 205, 72, .9),
  900: Color.fromRGBO(147, 205, 72, 1),
};

MaterialColor swatch = MaterialColor(0xFF262626, colorCodes);

class MyApp extends StatelessWidget {
  // Root widget of the application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tankomat',
      theme: ThemeData(
        primarySwatch: swatch,
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.black.withOpacity(0),
        ),
      ),
      initialRoute: '/loading',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
