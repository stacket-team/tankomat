import 'package:flutter/material.dart';
// import 'package:tankomat/components/BottomSheetWidget.dart';
// import 'package:tankomat/components/FloatingActionButton.dart';
import 'package:tankomat/views/Dashboard/DashboardView.dart';
import 'package:tankomat/views/Calendar/CalendarView.dart';
import 'package:tankomat/views/Home/components/NavigationBar.dart';
import 'package:tankomat/views/Map/MapView.dart';
import 'package:tankomat/views/Profile/ProfileView.dart';
import 'package:tankomat/constants.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeView> {
  int currentTab = 0;
  final List<Widget> tabs = [
    DashboardView(),
    MapView(),
    CalendarView(),
    ProfileView(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

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
