import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';

class Message extends StatefulWidget {
  const Message({
    Key? key,
    required this.title,
    required this.message,
    required this.sender,
    this.date,
    this.time,
    this.color,
  }) : super(key: key);

  final Color? color;
  final String title;
  final String sender;
  final String message;
  final Timestamp? date;
  final String? time;

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                widget.title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: widget.color,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          widget.sender,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 19),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: 'Date : ',
                            style: TextStyle(
                              color: themeChange.darkTheme
                                  ? Colors.white
                                  : Colors.black,
                              fontFamily: "Sofia",
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            )),
                        TextSpan(
                            text: '${(widget.date as Timestamp).toDate()}',
                            style: TextStyle(
                              color: themeChange.darkTheme
                                  ? Colors.white
                                  : Colors.black,
                              fontFamily: "Sofia",
                              fontSize: 15,
                            )),
                      ]),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color:themeChange.darkTheme? Colors.black: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  widget.message,
                  style: TextStyle(
                    fontSize: 20,
                    color: themeChange.darkTheme ? Colors.white : Colors.black,
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
