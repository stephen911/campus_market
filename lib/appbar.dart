
import 'package:flutter/material.dart';


class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  final PreferredSizeWidget bottom;
  MyAppBar({required this.bottom});

   Size get preferredSize => bottom == null
      ? Size(56, AppBar().preferredSize.height)
      : Size(56, 80 + AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: new LinearGradient(
                begin: const FractionalOffset(0, 0),
                end: const FractionalOffset(1, 0),
                stops: [0, 1],
                tileMode: TileMode.clamp,
                colors: [
                  Colors.white,
                  Colors.white
                ])),
      ),
      centerTitle: true,
      title: Text(
        "Campus Market",
        style: TextStyle(
            fontSize: 35, color: Colors.white, fontFamily: "Signatra"),
      ),
      // bottom: Size(56, AppBar().preferredSize.height),
      actions: [
        Stack(children: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.blue),
            onPressed: () {
              // Route route =
              //     MaterialPageRoute(builder: (c) => CartPage());
              // Navigator. push(context, route);
            },
          ),
          Positioned(
            child: Stack(children: [
              Positioned(
                child: Icon(
                  Icons.brightness_1,
                  size: 20.0,
                  color: Colors.blue,
                ),
              ),
              Positioned(
                top: 3,
                left: 7,
                bottom: 4,
                child: Text(
                  (2).toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ]),
          )
        ])
      ],
    );
  }

 
}
