import 'package:cloud_firestore/cloud_firestore.dart';

final ref = FirebaseFirestore.instance.collection("notifications").doc();

sendNotification({
  sender,
  receiver,
  title,
  DateTime? date,
  time,
  message,
  bool? opened,
  sortDate,
}) async {
  await ref.set({
    'sender': sender,
    'receiver': receiver,
    'title': title,
    'date': date,
    'time': time,
    'message': message,
    'opened': false,
    "parentId": ref.id,
    'sortDate': sortDate
  });
}
