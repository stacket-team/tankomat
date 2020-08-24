import 'package:flutter/material.dart';
// import 'package:tankomat/components/BottomSheetWidget.dart';
// import 'package:tankomat/components/FloatingActionButton.dart';
import 'package:tankomat/views/Dashboard/DashboardView.dart';
import 'package:tankomat/views/Calendar/CalendarView.dart';
import 'package:tankomat/views/Home/components/NavigationBar.dart';
// import 'package:tankomat/views/Map/MapView.dart';
import 'package:tankomat/views/Trainings/TrainingsView.dart';
import 'package:tankomat/views/Profile/ProfileView.dart';
import 'package:tankomat/constants.dart';
import 'package:tankomat/utils.dart' show Auth, User;

class HomeView extends StatefulWidget {
  final Auth auth;
  final User user;
  final Map arguments;

  HomeView(this.auth, this.user, this.arguments);

  @override
  _HomeState createState() => _HomeState(auth, user, arguments);
}

class _HomeState extends State<HomeView> {
  final PageStorageBucket bucket = PageStorageBucket();
  final Auth auth;
  final User user;
  final Map arguments;

  final List<Widget> tabs;
  int currentTab;

  _HomeState(this.auth, this.user, this.arguments)
      : tabs = [
          DashboardView(),
          TrainingsView(user),
          CalendarView(),
          ProfileView(auth, user),
        ] {
    if (arguments != null && arguments.containsKey('tab')) {
      currentTab = arguments['tab'];
    } else {
      currentTab = 0;
    }
  }

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
