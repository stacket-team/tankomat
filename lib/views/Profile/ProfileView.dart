import 'package:flutter/material.dart';
import 'package:tankomat/views/Profile/components/Body.dart';
import 'package:tankomat/utils.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: Body(
        onPress: () async {
          try {
            await logoutUser();
          } catch (e) {
            // TODO Add error message display
            print(e.toString());
          }
        },
      ),
    );
  }
}
