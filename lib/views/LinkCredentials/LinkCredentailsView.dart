import 'package:flutter/material.dart';
import 'package:tankomat/views/LinkCredentials/components/Body.dart';
import 'package:firebase/firebase.dart' as firebase;
import 'package:tankomat/utils.dart' show Auth;

class LinkCredentialsView extends StatefulWidget {
  final Auth auth;
  final Map arguments;

  LinkCredentialsView(this.auth, this.arguments);

  @override
  _LinkCredentialsViewState createState() =>
      _LinkCredentialsViewState(auth, arguments);
}

class _LinkCredentialsViewState extends State<LinkCredentialsView> {
  final TextEditingController passwordController = TextEditingController();
  final Auth auth;
  final Map arguments;
  bool loading = true;
  List<String> methods = [];

  _LinkCredentialsViewState(this.auth, this.arguments) {
    getMethods();
  }

  void getMethods() async {
    List<String> _methods = await auth.getLoginMethods(arguments['email']);
    setState(() {
      methods = _methods;
      loading = false;
    });
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        email: arguments['email'],
        providerString: arguments['providerString'],
        isLoading: loading,
        methods: methods,
        passwordController: passwordController,
        onPasswordLogin: () async {
          try {
            await auth.loginUser(arguments['email'], passwordController.text);
            await auth.linkCredentials(arguments['credential']);
          } on firebase.FirebaseError catch (e) {
            // TODO Add error display
            print(e.toString());
          }
        },
        onGoogleLogin: () async {
          try {
            await auth.loginUserWithGoogle(context);
            await auth.linkCredentials(arguments['credential']);
          } catch (e) {
            // TODO Add error display
            print(e.toString());
          }
        },
        onFacebookLogin: () async {
          try {
            await auth.loginUserWithFacebook(context);
            await auth.linkCredentials(arguments['credential']);
          } catch (e) {
            // TODO Add error display
            print(e.toString());
          }
        },
      ),
    );
  }
}
