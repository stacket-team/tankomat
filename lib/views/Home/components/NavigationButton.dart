import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  final String viewName;
  final int currentTab;
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
    Color color = currentTab == tabIndex ? Colors.blue : Colors.grey;
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
            color: color,
          ),
          Text(
            viewName,
            style: TextStyle(
              color: color,
            ),
          )
        ],
      ),
    );
  }
}
