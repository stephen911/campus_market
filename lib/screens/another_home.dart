// import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
// import 'package:flutter/material.dart';


// class AppScaffold extends StatelessWidget {
//   AppScaffold({required this.home});
//   final Widget home;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'MoneyTracker',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.indigo,
//         primaryColor: Colors.indigo,
//         secondaryHeaderColor: Colors.indigo,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: home,
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int currentIndex = 0;

//   void changePage(int index) {
//     setState(() {
//       currentIndex = index;
//     });
//   }

//   Widget callPage(int _selectedBar) {
//     switch (_selectedBar) {
//       case 0:
//         return Page1();
//       case 1:
//         return WalletPage();
//       case 2:
//         return EintraegePage();
//       case 3:
//         return KontenPage();
//         break;
//       default:
//         return null;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('MoneyTracker'),
//       ),
//       body: this.callPage(this.currentIndex),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {},
//         child: Icon(Icons.add),
//         backgroundColor: Colors.indigo,
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
//       bottomNavigationBar: BubbleBottomBar(
//         opacity: .2,
//         currentIndex: currentIndex,
//         onTap: changePage,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//         elevation: 8,
//         fabLocation: BubbleBottomBarFabLocation.end, //new
//         hasNotch: true, //new
//         hasInk: true, //new, gives a cute ink effect
//         inkColor: Colors.black12, //optional, uses theme color if not specified
//         items: <BubbleBottomBarItem>[
//           BubbleBottomBarItem(
//               //Home
//               backgroundColor: Colors.indigo,
//               icon: Icon(
//                 Icons.home,
//                 color: Colors.black,
//               ),
//               activeIcon: Icon(
//                 Icons.home,
//                 color: Colors.indigo,
//               ),
//               title: Text("Start")),
//           BubbleBottomBarItem(
//               //Wallet
//               backgroundColor: Colors.green[800],
//               icon: Icon(
//                 Icons.account_balance_wallet,
//                 color: Colors.black,
//               ),
//               activeIcon: Icon(
//                 Icons.account_balance_wallet,
//                 color: Colors.green[800],
//               ),
//               title: Text("Wallet")),
//           BubbleBottomBarItem(
//               //Icon3
//               backgroundColor: Colors.deepOrange,
//               icon: Icon(
//                 Icons.credit_card,
//                 color: Colors.black,
//               ),
//               activeIcon: Icon(
//                 Icons.credit_card,
//                 color: Colors.deepOrange,
//               ),
//               title: Text("Konten")),
//           BubbleBottomBarItem(
//               //Icon 4
//               backgroundColor: Colors.deepPurple,
//               icon: Icon(
//                 Icons.menu,
//                 color: Colors.black,
//               ),
//               activeIcon: Icon(
//                 Icons.menu,
//                 color: Colors.deepPurple,
//               ),
//               title: Text("Einträge"))
//         ],
//       ),
//     );
//   }
// }

// class Page1 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text("Page1"));
//   }
// }

// class WalletPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text("WalletPage"));
//   }
// }

// class EintraegePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text("EintraegePage"));
//   }
// }

// class KontenPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(child: Text("KontenPage"));
//   }
// }