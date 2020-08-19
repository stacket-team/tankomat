import 'package:flutter/material.dart';
import 'package:tankomat/views/LinkCredentials/components/Body.dart';
import 'package:firebase/firebase.dart' as firebase;
import 'package:tankomat/utils.dart';

class LinkCredentialsView extends StatefulWidget {
  final Map arguments;

  LinkCredentialsView(this.arguments);

  @override
  _LinkCredentialsViewState createState() =>
      _LinkCredentialsViewState(arguments);
}

class _LinkCredentialsViewState extends State<LinkCredentialsView> {
  final TextEditingController passwordController = TextEditingController();
  final Map arguments;
  bool loading = true;
  List<String> methods = [];

  _LinkCredentialsViewState(this.arguments) {
    getMethods();
  }

  void getMethods() async {
    List<String> _methods = await getLoginMethods(arguments['email']);
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
            await loginUser(arguments['email'], passwordController.text);
            await linkCredentials(arguments['credential']);
          } on firebase.FirebaseError catch (e) {
            // TODO Add error display
            print(e.toString());
          }
        },
        onGoogleLogin: () async {
          try {
            await loginUserWithGoogle(context);
            await linkCredentials(arguments['credential']);
          } catch (e) {
            // TODO Add error display
            print(e.toString());
          }
        },
        onFacebookLogin: () async {
          try {
            await loginUserWithFacebook(context);
            await linkCredentials(arguments['credential']);
          } catch (e) {
            // TODO Add error display
            print(e.toString());
          }
        },
      ),
    );
  }
}
