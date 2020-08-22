import 'package:flutter/material.dart';
import 'package:tankomat/components/Background.dart';
import 'package:tankomat/components/Button.dart';
import 'package:tankomat/views/Profile/components/Avatar.dart';
import 'package:tankomat/views/Profile/components/Provider.dart';

class Body extends StatelessWidget {
  final Function onLogoutPress;
  final List<String> providers;
  final String username;
  final String avatarURL;
  final Function onUnlinkPasswordPress;
  final Function onLinkPasswordPress;
  final Function onUnlinkGooglePress;
  final Function onLinkGooglePress;
  final Function onUnlinkFacebookPress;
  final Function onLinkFacebookPress;

  Body({
    Key key,
    this.onLogoutPress,
    this.username,
    this.avatarURL,
    this.providers,
    this.onUnlinkPasswordPress,
    this.onLinkPasswordPress,
    this.onUnlinkGooglePress,
    this.onLinkGooglePress,
    this.onUnlinkFacebookPress,
    this.onLinkFacebookPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    children.add(Avatar(
      onPress: () {
        // TODO Navigate to custom avatar view
      },
      url: avatarURL,
    ));
    children.add(Text(username));

    if (providers.contains('password')) {
      children.add(Provider(
        name: 'Odłącz hasło',
        imageSrc: 'password.png',
        onPress: onUnlinkPasswordPress,
      ));
    } else {
      children.add(Provider(
        name: 'Podłącz hasło',
        imageSrc: 'password.png',
        onPress: onLinkPasswordPress,
      ));
    }
    if (providers.contains('google.com')) {
      children.add(Provider(
        name: 'Odłącz Google',
        imageSrc: 'google.png',
        onPress: onUnlinkGooglePress,
      ));
    } else {
      children.add(Provider(
        name: 'Podłącz Google',
        imageSrc: 'google.png',
        onPress: onLinkGooglePress,
      ));
    }
    if (providers.contains('facebook.com')) {
      children.add(Provider(
        name: 'Odłącz Facebook',
        imageSrc: 'facebook.png',
        onPress: onUnlinkFacebookPress,
      ));
    } else {
      children.add(Provider(
        name: 'Podłącz Facebook',
        imageSrc: 'facebook.png',
        onPress: onLinkFacebookPress,
      ));
    }

    children.add(Button(
      text: 'Wyloguj się',
      press: onLogoutPress,
    ));

    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}
