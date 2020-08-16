import 'package:flutter/material.dart';
import 'package:tankomat/views/Register/components/Body.dart';
import 'package:firebase/firebase.dart' as firebase;
import 'package:firebase/firestore.dart' as firestore;
import 'package:tankomat/views/Login/LoginView.dart';

class RegisterView extends StatelessWidget {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firebase.Auth auth;
  final firestore.CollectionReference ref;

  RegisterView()
      : auth = firebase.auth(),
        ref = firebase.firestore().collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        nameController: nameController,
        emailController: emailController,
        passwordController: passwordController,
        onPress: () async {
          bool trySignin = false;
          // TODO Validate email and password
          String name = nameController.text;
          String email = emailController.text;
          String password = passwordController.text;
          try {
            String uid =
                (await auth.createUserWithEmailAndPassword(email, password))
                    .user
                    .uid;

            Map<String, dynamic> userData = {
              'name': name,
              'type': null,
              'history': [],
            };

            try {
              await ref.doc(uid).set(userData);
            } catch (e) {
              print(e.toString());
            }

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginView()),
            );
          } on firebase.FirebaseError catch (e) {
            if (e.code == 'auth/email-already-in-use') {
              trySignin = true;
            }
          } catch (e) {
            // TODO Add error message display
            print(e.toString());
          }

          if (trySignin) {
            try {
              firebase.User user =
                  (await auth.signInWithEmailAndPassword(email, password)).user;
              if (user != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginView()),
                );
              }
            } catch (e) {
              // TODO Add error message display
              print(e.toString());
            }
          }
        },
      ),
    );
  }
}

// class RegisterView extends StatefulWidget {
//   RegisterView({Key key, this.title}) : super(key: key);
//   final String title;
//   @override
//   _RegisterViewState createState() => _RegisterViewState();
// }

// class _RegisterViewState extends State<RegisterView> {
//   TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

//   @override
//   Widget build(BuildContext context) {
//     final nameField = TextField(
//       obscureText: false,
//       style: style,
//       decoration: InputDecoration(
//         contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//         hintText: 'Name',
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
//       ),
//     );

//     final emailField = TextField(
//       obscureText: false,
//       style: style,
//       decoration: InputDecoration(
//         contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//         hintText: 'E-mail',
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
//       ),
//     );

//     final passwordField = TextField(
//       obscureText: true,
//       style: style,
//       decoration: InputDecoration(
//         contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//         hintText: 'Haslo',
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
//       ),
//     );

//     final registerButton = Material(
//         elevation: 5.0,
//         borderRadius: BorderRadius.circular(30.0),
//         color: Color(0xff01A0C7),
//         child: MaterialButton(
//           minWidth: MediaQuery.of(context).size.width,
//           padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//           onPressed: () {},
//           child: Text(
//             'Register',
//             textAlign: TextAlign.center,
//             style: style.copyWith(
//                 color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//         ));

//     final signUpButton = FlatButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => LoginView()),
//           );
//         },
//         child: Text('Masz juz konto? Zaloguj sie tutaj!'));

//     return Scaffold(
//       body: Center(
//         child: Container(
//             color: Colors.white,
//             child: Padding(
//                 padding: const EdgeInsets.all(36.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     nameField,
//                     SizedBox(height: 25.0),
//                     emailField,
//                     SizedBox(height: 25.0),
//                     passwordField,
//                     SizedBox(height: 25.0),
//                     registerButton,
//                     SizedBox(height: 10.0),
//                     signUpButton,
//                   ],
//                 ))),
//       ),
//     );
//   }
// }
