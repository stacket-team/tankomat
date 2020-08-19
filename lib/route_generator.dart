import 'package:flutter/material.dart';
import 'package:tankomat/views/Loading/LoadingView.dart';
import 'package:tankomat/views/VerifyEmail/VerifyEmailView.dart';
import 'package:tankomat/views/LinkCredentials/LinkCredentailsView.dart';
import 'views/Home/HomeView.dart';
import 'views/Login/LoginView.dart';
import 'views/Register/RegisterView.dart';

class InstantPageRoute<T> extends MaterialPageRoute<T> {
  InstantPageRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return InstantPageRoute(builder: (_) => HomeView());
      case '/login':
        return InstantPageRoute(builder: (_) => LoginView());
      case '/register':
        return InstantPageRoute(builder: (_) => RegisterView());
      case '/verifyEmail':
        return InstantPageRoute(builder: (_) => VerifyEmailView());
      case '/linkCredentials':
        return InstantPageRoute(builder: (_) => LinkCredentialsView(args));
      case '/loading':
        return InstantPageRoute(builder: (_) => LoadingView());
      default:
        // If there is no such named route in the switch statement
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return InstantPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: Text('Error')),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
