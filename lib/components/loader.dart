import 'package:flutter/material.dart';

class LoadIndicator extends StatefulWidget {
  const LoadIndicator({Key? key}) : super(key: key);

  @override
  _LoadIndicatorState createState() => _LoadIndicatorState();
}

class _LoadIndicatorState extends State<LoadIndicator> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      color: Colors.transparent,
      child: Center(
          child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(15)),
              child: Center(
                  child: Image.asset(
                'assets/gifs/loader.gif',
                height: 70,
                width: 70,
              )))),
    );
  }
}
