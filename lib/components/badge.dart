import 'package:flutter/material.dart';

Widget badge({required parentWidget, required childWidget, double? height,required VoidCallback onTap}) {
  return TextButton(
    onPressed: onTap,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        parentWidget,
        Positioned(
          bottom: -3,
          right: -5,
          child: Container(
            height: height,
            width: height,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(height!=null?height/2:10),
              
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:5,vertical: 3),
              child: childWidget,),
          ),
        )
      ],
    ),
  );
}
