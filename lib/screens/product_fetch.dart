import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductFetch extends StatefulWidget {
  const ProductFetch({Key? key}) : super(key: key);

  @override
  State<ProductFetch> createState() => _ProductFetchState();
}

List? allData;
CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('products');
Future<void> getData() async {
  QuerySnapshot querySnapshot = await _collectionRef.get();
  allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  print(allData![0]["status"]);
}

class _ProductFetchState extends State<ProductFetch> {
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          child: TextButton(
            child: Text("tap"),
            onPressed: getData,
          ),
        ),
      ),
    );
  }
}
