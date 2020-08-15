import 'package:flutter/material.dart';
import 'package:tankomat/views/Register/RegisterView.dart';
import 'package:firebase/firebase.dart' as firebase;

class LoginView extends StatefulWidget {
  LoginView({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firebase.Auth auth;

  _LoginViewState() : auth = firebase.auth() {
    auth.onAuthStateChanged.listen((firebase.User user) async {
      if (user != null) {
        if (user.emailVerified) {
          // TODO Redirect to Home instead of Register view
        } else {
          try {
            // TODO Change auth.languageCode to user language
            await auth.currentUser.sendEmailVerification(
                firebase.ActionCodeSettings(
                    url: 'https://stacket-tankomat.firebaseapp.com'));
          } catch (e) {
            // TODO Display information about email verification
            print(e.toString());
          }
        }
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginView()),
        );
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      obscureText: false,
      style: style,
      controller: emailController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'E-mail',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final passwordField = TextField(
      obscureText: true,
      style: style,
      controller: passwordController,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: 'Haslo',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          try {
            // TODO Validate email and password
            String email = emailController.text;
            String password = passwordController.text;
            await auth.signInWithEmailAndPassword(email, password);
          } catch (e) {
            // TODO Add error message display
            print(e.toString());
          }
        },
        child: Text(
          'Zaloguj sie',
          textAlign: TextAlign.center,
          style:
              style.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );

    final registerButton = FlatButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterView()),
        );
      },
      child: Text('Nie masz konta? Zarejestruj sie?'),
    );

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 155.0,
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 45.0),
                emailField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(height: 35.0),
                loginButton,
                SizedBox(height: 10.0),
                registerButton,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
