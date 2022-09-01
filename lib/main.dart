import 'dart:io';

import 'package:campus_market/components/constants.dart';
import 'package:campus_market/providers/theme_provider.dart';
import 'package:campus_market/screens/product_fetch.dart';
import 'package:campus_market/splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'package:path_provider/path_provider.dart';
import 'package:campus_market/Counters/ItemQuantity.dart';

// import 'package:campus_market/Components/constants.dart';
import 'package:campus_market/Counters/cartitemcounter.dart';
import 'package:campus_market/Counters/changeAddresss.dart';
import 'package:campus_market/Counters/totalMoney.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // String path = './';
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  await Hive.openBox("CartCounter");
  // await Hive.openBox("country");

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => CartItemCounter()),
        ChangeNotifierProvider(create: (c) => ItemQuantity()),
        ChangeNotifierProvider(create: (c) => AddressChanger()),
        ChangeNotifierProvider(create: (c) => TotalAmount()),
        ChangeNotifierProvider(create: (_) => themeChangeProvider)
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (BuildContext context, value, Widget) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
