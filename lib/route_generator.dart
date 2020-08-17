import 'package:flutter/material.dart';
import 'package:tankomat/views/VerifyEmail/VerifyEmailView.dart';
import 'views/HomeView.dart';
import 'views/Login/LoginView.dart';
import 'views/Register/RegisterView.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeView());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginView());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterView());
      case '/verifyEmail':
        return MaterialPageRoute(builder: (_) => VerifyEmailView());
      default:
        // If there is no such named route in the switch statement
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: Text('Error')),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
