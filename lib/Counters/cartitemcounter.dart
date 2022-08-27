import 'package:campus_market/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CartItemCounter extends ChangeNotifier {
//   List emtdata= [];


//  CollectionReference _collectionRef =
//       FirebaseFirestore.instance.collection('carts');
//   Future<void> getData() async {
//     QuerySnapshot querySnapshot = await _collectionRef.get();

//     List emtdata = querySnapshot.docs.map((doc) => doc.data()).toList();
//     // setState(() {
//     //   allData = emtdata;
//     // });

//     print(emtdata[0]["price"]);
//   }


    // print(allData[0]["price"]);
  
  // int _counter = EcommerceApp.sharedPreferences!.getStringList(EcommerceApp.userCartList)!.length-1;
  int _counter = 0;
  int get count => _counter;
  Future<void> displayResult() async {
    //int _counter = EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList).length-1;
    await Future.delayed(const Duration(milliseconds: 100), () {
      notifyListeners();
    });
  }
}
