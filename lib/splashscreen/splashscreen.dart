import 'dart:async';

import 'package:campus_market/components/constants.dart';
import 'package:campus_market/screens/home.dart';
import 'package:campus_market/screens/sign_in/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/default_button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final User? _user = FirebaseAuth.instance.currentUser;

  int currentPage = 0;

  @override

  // void initState() {
  //   super.initState();
  //   startTime();
  // }

  // startTime() async {
  //   Timer(const Duration(milliseconds: 2500), navigatorPage);
  // }

  // Future<void> navigatorPage() async {
  //   _user != null
  //       ? Navigator.of(context).pushReplacement(
  //           PageRouteBuilder(pageBuilder: (_, __, ___) => const LoginScreen()))
  //       : Navigator.of(context).pushReplacement(
  //           PageRouteBuilder(pageBuilder: (_, __, ___) => const MyHomePage()));
  // }
  Widget build(BuildContext context) {
    List splashData = [
      {
        "text": "Welcome to UCC campus market, Let’s shop!",
        "image": "assets/images/splash1.PNG"
      },
      {
        "text": "We help people conect with store \naround Cape Coast, Ghana",
        "image": "assets/images/splash2.PNG"
      },
      {
        "text": "We show the easy way to shop. \nJust stay at home with us",
        "image": "assets/images/splash_3.png"
      },
    ];
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: splashData.length,
                  itemBuilder: (context, index) => SplashContent(
                    text: splashData[index]["text"],
                    image: splashData[index]["image"],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: <Widget>[
                      Spacer(
                        flex: 1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          splashData.length,
                          (index) => buildDot(index: index),
                        ),
                      ),
                      Spacer(flex: 1),
                      GetStarted(() { 
                        Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const MyHomePage()));
                      }, "Get started"),
                       
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? Colors.green : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    required this.text,
    required this.image,
  }) : super(key: key);
  final String text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(
          flex: 2,
        ),
        Row(
          children: [
            SizedBox(width: 30,),
            Container(
              width: 100,
              child: Image.asset("assets/images/playstore.png", fit: BoxFit.contain),
            ),
            // SizedBox(width: 5,),
            Text(
              "CAMPUS MART",
              style: TextStyle(
                fontSize: 30,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        // SizedBox(height: 10),
        Text(
          text,
          textAlign: TextAlign.center,
        ),
        Spacer(flex: 2),
        Image.asset(
          
          image,
          fit: BoxFit.contain,
          height: 255,
          width: 235,
        ),
      ],
    );
  }
}
Widget GetStarted(VoidCallback press, String text){
  return  SizedBox(
      width: double.infinity,
      height: 56,
      child: TextButton(
        style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          primary: Colors.white,
          backgroundColor: Colors.green,
        ),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
}