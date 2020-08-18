import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NavigationButton extends StatelessWidget {
  final String viewName;
  int currentTab = 0;
  final int tabIndex;
  final Function handleTabChange;
  final IconData iconName;
  NavigationButton({
    Key key,
    this.viewName,
    this.currentTab,
    this.tabIndex,
    this.handleTabChange,
    this.iconName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: 40.0,
      onPressed: () {
        handleTabChange(tabIndex);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            iconName,
            color: currentTab == tabIndex ? Colors.blue : Colors.grey,
          ),
          Text(
            viewName,
            style: TextStyle(
              color: currentTab == tabIndex ? Colors.blue : Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
