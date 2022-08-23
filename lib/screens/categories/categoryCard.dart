import 'package:campus_market/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryModel extends StatelessWidget {
  // final String image;
  final String title;
  final String img;
  final String tag;
  final String price;

  const CategoryModel(
      {
      // required Key key,
      // required this.image,
      required this.title,
      required this.tag,
      required this.price,
      required this.img});

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Stack(clipBehavior: Clip.none, children: [
      Positioned(
          child: Container(
        height: 180,
        width: 150,
        margin: EdgeInsets.only(left: 30),
        padding: EdgeInsets.only(right: 0, left: 10),
        decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                  offset: Offset(0, 0), color: Colors.black26, blurRadius: 5),
            ],
            color: themeChange.darkTheme ? Colors.black87 : Colors.white,
            borderRadius: BorderRadius.circular(10)),
      )),
      Positioned(
        top: 20,
        right: -30,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: Image.asset(img).image, fit: BoxFit.fill)),
                width: 150,
                height: 150)),
      ),
      Positioned(
          top: 5,
          left: 70,
          child:
              Text(this.title, style: TextStyle(fontWeight: FontWeight.bold))),
      Positioned(
          bottom: 1,
          left: 30,
          child: Container(
              margin: EdgeInsets.all(1),
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: this.tag == "new"
                      ? Colors.redAccent
                      : this.tag == "upcoming"
                          ? Colors.blueAccent
                          : this.tag == "popular"
                              ? Colors.greenAccent
                              : Colors.orange),
              child: Text(this.tag,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)))),
      Positioned(
          top: 30,
          left: 30,
          child: Container(
              margin: EdgeInsets.all(1),
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: this.tag == "new"
                      ? Colors.redAccent
                      : this.tag == "upcoming"
                          ? Colors.blueAccent
                          : this.tag == "popular"
                              ? Colors.greenAccent
                              : Colors.orange),
              child: Text("Ghc " + this.price,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold))))
    ]);
  }
}
