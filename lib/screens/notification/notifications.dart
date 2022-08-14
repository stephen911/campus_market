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
        padding: EdgeInsets.all(10),
        color: Colors.green,
        child: Column(children: [
          for (int i = 0; i < 8; i++) 
            NotificationCard(
              parentId: 'parentId',
              message: 'your order has been approved',
              title: 'order',
              time: DateFormat('Hm').format(DateTime.now()).toString(),
              onTap: () {
                print("card has been tapped");
              },
              opened: true,
              date: DateTime.now().toString(),
              color: randomColors[i % 7],
              sender: ' Owner',
            ),
        ]),
      ),
    );
  }
}
