import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:campus_market/profile/profile.dart';
import 'package:campus_market/screens/home.dart';
import 'package:flutter/material.dart';

import '../screens/categories/categories.dart';
import '../screens/notification/notifications.dart';

class HomeAfterSignIn extends StatefulWidget {
  const HomeAfterSignIn({Key? key}) : super(key: key);

  @override
  State<HomeAfterSignIn> createState() => _HomeAfterSignInState();
}

class _HomeAfterSignInState extends State<HomeAfterSignIn> {
  int currentIndex = 0;
  List Navbody = [
    // this isthe content of the home page
    HomePageContent(),
    /////the content of the profile page
    ProfilePage(),
    //////the content of the categories page
    Categories(),
    //////the content of the notification page

    Notifications(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavyBar(
        animationDuration: Duration(milliseconds: 5),
        // backgroundColor: Colors.black,
        curve: Curves.elasticIn,
        selectedIndex: currentIndex,
        onItemSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            activeColor: Colors.blueAccent,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text("profile"),
            activeColor: Colors.deepOrangeAccent,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.category),
            title: Text("categories"),
            activeColor: Colors.redAccent,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.notifications),
            title: Text("notification"),
            activeColor: Colors.green,
            inactiveColor: Colors.black,
          ),
        ],
      ),
      body: Navbody[currentIndex],
    );
  }
}
