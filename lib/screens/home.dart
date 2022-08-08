import 'package:campus_market/screens/categories.dart';
import 'package:campus_market/screens/notifications.dart';
import 'package:campus_market/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  List Navbody = [
    // this isthe contant of the home page
    HomePageContent(),

    /////the contant of the profile page
    ProfilePage(),
    //////the contant of the categories page
    Categories(),
    //////the contant of the notification page

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

class HomePageContent extends StatefulWidget {
  const HomePageContent({Key? key}) : super(key: key);

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blueAccent,
        child: Center(
          child: Text("content of the home page goes here"),
        ),
      ),
    );
  }
}
