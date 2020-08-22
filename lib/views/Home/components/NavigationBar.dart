import 'package:flutter/material.dart';
import 'package:tankomat/views/Home/components/NavigationButton.dart';

class NavigationBar extends StatelessWidget {
  final int currentTab;
  final Function handleTabChange;

  NavigationBar({
    Key key,
    this.currentTab,
    this.handleTabChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Container(
        height: 60.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              children: <Widget>[
                NavigationButton(
                  viewName: 'Panel',
                  currentTab: currentTab,
                  tabIndex: 0,
                  handleTabChange: handleTabChange,
                  iconName: Icons.dashboard,
                ),
                NavigationButton(
                  viewName: 'Mapa',
                  currentTab: currentTab,
                  tabIndex: 1,
                  handleTabChange: handleTabChange,
                  iconName: Icons.map,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                NavigationButton(
                  viewName: 'Kalendarz',
                  currentTab: currentTab,
                  tabIndex: 2,
                  handleTabChange: handleTabChange,
                  iconName: Icons.calendar_today,
                ),
                NavigationButton(
                  viewName: 'Profil',
                  currentTab: currentTab,
                  tabIndex: 3,
                  handleTabChange: handleTabChange,
                  iconName: Icons.person,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
