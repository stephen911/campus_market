import 'package:campus_market/cartProduct.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/check_out_card.dart';
import '../../model/user_model.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List allData = [];
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  double totalcal = 0;
  double total = 0;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });

    setState(() {
      getData();
    });
  }

  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('carts');
  Future<void> getData() async {
    QuerySnapshot querySnapshot = await _collectionRef.get();

    List emtdata = querySnapshot.docs.map((doc) => doc.data()).toList();
    setState(() {
      allData = emtdata;
    });

    print(allData[0]["price"]);
    for (int i = 0; i < allData.length; i++) {
      if (allData[i]['uid'] == user!.uid) {
        totalcal += allData[i]["price"] -
            (allData[i]["price"] * allData[i]["discount"] * 0.01);
      }
    }
    setState(() {
      total = totalcal;
    });
    print(total);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          itemCount: allData.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: allData[index]["uid"] == user!.uid
                ? CartProduct(
                    description: allData[index]["description"].toString(),
                    productId: allData[index]["productId"].toString(),
                    discount: allData[index]["discount"],
                    img: allData[index]["productFile"].toString(),
                    price: allData[index]["price"],
                    title: allData[index]["title"].toString(),
                    sellerUid: allData[index]["sellerUid"].toString(),
                    brand: allData[index]["brand"].toString(),
                    category: allData[index]["category"].toString(),
                  )
                : beginBuildingCart(),
          ),
        ),
      ),
      bottomNavigationBar:
          CheckoutCard(total: total.toStringAsFixed(2), tap: () {}),
    );
  }

  beginBuildingCart() {
    return SliverToBoxAdapter(
        child: Card(
            color: Theme.of(context).primaryColor.withOpacity(0.6),
            child: Container(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.insert_emoticon,
                    color: Colors.white,
                  ),
                  Text("Cart is empty"),
                  Text("Start adding items to your cart"),
                ],
              ),
            )));
  }
}
