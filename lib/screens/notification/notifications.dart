import 'package:campus_market/screens/notification/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../components/notification_card.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

List<Color> randomColors = [
  Colors.red,
  Colors.orange,
  Colors.green,
  Colors.blue,
  Colors.indigo,
  Colors.yellow,
  Colors.lightBlue
];

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(
          top: 10,
        ),
        padding: EdgeInsets.all(10),
        child: Column(children: [
          for (int i = 0; i < 7; i++)
            NotificationCard(
              parentId: 'parentId',
              message: ' your order has been approved.',
              title: 'order',
              time: DateFormat('Hm').format(DateTime.now()).toString(),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Message(
                              title: "Order",
                              message: "your order has been approved.",
                              sender: "Campus Mart",
                              time: DateFormat('Hm')
                                  .format(DateTime.now())
                                  .toString(),
                              date: Timestamp.fromDate(DateTime.now()),
                              color: randomColors[i % 7],
                            )));
                            
              },
              opened: false,
              date: DateTime.now().toString(),
              color: randomColors[i % 7],
              sender: ' campus Mart',
            ),
        ]),
      ),
    );
  }
}
