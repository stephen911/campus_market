import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard(
      {Key? key,
      required this.title,
      required this.message,
      required this.sender,
      this.parentId,
      this.date,
      this.time,
      this.opened,
      this.color,
      required this.onTap})
      : super(key: key);
  final Color? color;
  final String title;
  final String sender;
  final String message;
  final String? date;
  final String? time;
  final VoidCallback onTap;
  final bool? opened;
  final String? parentId;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey, width: 1),
            // left: BorderSide(color: Colors.grey, width: 1),
          ),
        ),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.1,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: color,
              ),
              child: const Center(
                child: Icon(
                  Icons.notifications_active,
                  color: Colors.black,
                  size: 15,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        sender,
                        style: opened!
                            ? const TextStyle(
                                color: Colors.grey,
                              )
                            : const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        time!,
                        style: opened!
                            ? const TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              )
                            : const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  FittedBox(
                    fit: BoxFit.fill,
                    child: Text(
                      message,
                      style: opened!
                          ? const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis)
                          : const TextStyle(
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
