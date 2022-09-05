import 'package:flutter/material.dart';

import '../components/badge.dart';

// Widget appBar(){
//   return AppBar(
//         elevation: 0,
//         iconTheme: IconThemeData(color: Colors.black),
//         backgroundColor: Color.fromARGB(255, 247, 247, 247),
//         actions: [
//           IconButton(
//               onPressed: () {},
//               icon: Icon(
//                 Icons.feed,
//                 color: Colors.black,
//               )),
//           badge(
//             height: 10,
//               parentWidget: Icon(Icons.shopping_cart),
//               childWidget: 2,
//               onTap: () {
//                 Navigator.of(context)
//                     .push(MaterialPageRoute(builder: (context) => CartPage()));
//               })
//           // IconButton(
//           //     onPressed: () {
//           //       Navigator.of(context)
//           //           .push(MaterialPageRoute(builder: (context) => CartPage()));
//           //     },
//           //     icon: Icon(
//           //       Icons.shopping_cart,
//           //       color: Colors.black,
//           //     ))
//         ],
//       );
// }