import 'package:flutter/material.dart';
// import 'package:tankomat/components/BottomSheetWidget.dart';
// import 'package:tankomat/components/FloatingActionButton.dart';
import 'package:tankomat/views/Dashboard/DashboardView.dart';
import 'package:tankomat/views/Calendar/CalendarView.dart';
import 'package:tankomat/views/Home/components/NavigationBar.dart';
import 'package:tankomat/views/Map/MapView.dart';
import 'package:tankomat/views/Profile/ProfileView.dart';
import 'package:tankomat/constants.dart';
import 'package:tankomat/utils.dart' show Auth, User;

class HomeView extends StatefulWidget {
  final Auth auth;
  final User user;

  HomeView(this.auth, this.user);

  @override
  _HomeState createState() => _HomeState(auth, user);
}

class _HomeState extends State<HomeView> {
  final PageStorageBucket bucket = PageStorageBucket();
  final Auth auth;
  final User user;

  final List<Widget> tabs;
  int currentTab = 0;

  _HomeState(this.auth, this.user)
      : tabs = [
          DashboardView(),
          MapView(),
          CalendarView(),
          ProfileView(auth, user),
        ];

  void handleTabChange(int tabIndex) {
    setState(() {
      currentTab = tabIndex;
    });
  }

  // PersistentBottomSheetController handleFabButtonPress(context) {
  //   return showBottomSheet(
  //     context: context,
  //     builder: (context) => BottomSheetWidget(),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: tabs[currentTab],
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: PRIMARY_COLOR,
        onPressed: () {
          Navigator.of(context).pushNamed('/add');
        },
      ),
      // AddInfoButton(handleFabButtonPress: handleFabButtonPress),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: NavigationBar(
        currentTab: currentTab,
        handleTabChange: handleTabChange,
      ),
    );
  }
}
