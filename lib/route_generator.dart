import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as firebase;
import 'package:tankomat/utils.dart';
import 'package:tankomat/views/AddTraining/AddTrainingView.dart';
import 'package:tankomat/views/Finished/FinishedView.dart';
import 'package:tankomat/views/Training/TrainingView.dart';
import 'views/ForgotPassword/ForgotPasswordView.dart';
import 'views/Loading/LoadingView.dart';
import 'views/VerifyEmail/VerifyEmailView.dart';
import 'views/LinkCredentials/LinkCredentailsView.dart';
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
  static Auth auth;
  static User user;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    return InstantPageRoute(
      builder: (context) {
        if (auth == null) {
          auth = initializeAuth(
            context,
            (firebase.User firebaseUser) {
              user = User(firebaseUser, auth);
            },
          );
        }

        switch (settings.name) {
          case '/':
            return HomeView(auth, user, settings.arguments);
          case '/login':
            return LoginView(auth);
          case '/register':
            return RegisterView(auth);
          case '/verifyEmail':
            return VerifyEmailView(auth);
          case '/linkCredentials':
            return LinkCredentialsView(auth, settings.arguments);
          case '/forgotPassword':
            return ForgotPasswordView(auth, settings.arguments);
          case '/loading':
            return LoadingView();
          case '/add':
            return AddTrainingView(user);
          case '/training':
            return TrainingView(user, settings.arguments);
          case '/finished':
            return FinishedView(user, settings.arguments);
          default:
            return errorRoute();
        }
      },
      settings: settings,
    );
  }

  static Widget errorRoute() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Error 404'),
        leading: Container(),
      ),
      body: Center(
        child: Text('Error 404 - Not found'),
      ),
    );
  }
}
