import 'package:flutter/material.dart';
import 'package:tankomat/views/Profile/components/Body.dart';
import 'package:tankomat/utils.dart' show Auth, User;

class ProfileView extends StatefulWidget {
  final Auth auth;
  final User user;

  ProfileView(this.auth, this.user);

  @override
  _ProfileState createState() => _ProfileState(auth, user);
}

class _ProfileState extends State<ProfileView> {
  String name = '';
  List<String> providers = [];
  int listenerID;
  final Auth auth;
  final User user;

  _ProfileState(this.auth, this.user) {
    listenerID = user.onEvent('load', (immediate) {
      if (immediate) {
        name = user.name;
        providers = user.providers;
      } else {
        setState(() {
          name = user.name;
          providers = user.providers;
        });
      }
    });
    user.reloadAuth();
  }

  @override
  void dispose() {
    user.offEvent('load', listenerID);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text('Profil'),
      ),
      body: Body(
        onLogoutPress: () async {
          try {
            await auth.logoutUser();
          } catch (e) {
            // TODO Add error message display
            print(e.toString());
          }
        },
        username: name,
        avatarURL: user.photoURL,
        providers: providers,
        onLinkPasswordPress: () async {
          try {
            // TODO Add view for adding password auth
          } catch (e) {
            print(e.toString());
          }
        },
        onUnlinkPasswordPress: () async {
          try {
            if (providers.length > 1) {
              await auth.unlinkPassword();
              user.reloadAuth();
            } else {
              // TODO Add error display
            }
          } catch (e) {
            print(e.toString());
          }
        },
        onLinkGooglePress: () async {
          try {
            await auth.linkGoogle();
            user.reloadAuth();
          } catch (e) {
            print(e.toString());
          }
        },
        onUnlinkGooglePress: () async {
          try {
            if (providers.length > 1) {
              await auth.unlinkGoogle();
              user.reloadAuth();
            } else {
              // TODO Add error display
            }
          } catch (e) {
            print(e.toString());
          }
        },
        onLinkFacebookPress: () async {
          try {
            await auth.linkFacebook();
            user.reloadAuth();
          } catch (e) {
            print(e.toString());
          }
        },
        onUnlinkFacebookPress: () async {
          try {
            if (providers.length > 1) {
              await auth.unlinkFacebook();
              user.reloadAuth();
            } else {
              // TODO Add error display
            }
          } catch (e) {
            print(e.toString());
          }
        },
      ),
    );
  }
}
