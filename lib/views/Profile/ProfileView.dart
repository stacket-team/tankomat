import 'package:flutter/material.dart';
import 'package:tankomat/views/Profile/components/Body.dart';
import 'package:tankomat/utils.dart';
import 'package:firebase/firebase.dart' as firebase;

class ProfileView extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<ProfileView> {
  List<String> providers = [];
  final firebase.Auth auth;

  _ProfileState() : auth = firebase.auth() {
    getProviders();
  }

  void getProviders() async {
    try {
      List<String> _providers = await getLoginMethods(auth.currentUser.email);
      setState(() {
        providers = _providers;
      });
    } catch (e) {
      // TODO Add error display
      print(e.toString());
    }
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
            await logoutUser();
          } catch (e) {
            // TODO Add error message display
            print(e.toString());
          }
        },
        areProvidersLoading: providers.isEmpty,
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
              await unlinkPassword();
              getProviders();
            } else {
              // TODO Add error display
            }
          } catch (e) {
            print(e.toString());
          }
        },
        onLinkGooglePress: () async {
          try {
            await linkGoogle();
            getProviders();
          } catch (e) {
            print(e.toString());
          }
        },
        onUnlinkGooglePress: () async {
          try {
            if (providers.length > 1) {
              await unlinkGoogle();
              getProviders();
            } else {
              // TODO Add error display
            }
          } catch (e) {
            print(e.toString());
          }
        },
        onLinkFacebookPress: () async {
          try {
            await linkFacebook();
            getProviders();
          } catch (e) {
            print(e.toString());
          }
        },
        onUnlinkFacebookPress: () async {
          try {
            if (providers.length > 1) {
              await unlinkFacebook();
              getProviders();
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
