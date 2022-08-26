//import 'dart:wasm';

import 'package:campus_market/Counters/cartitemcounter.dart';
import 'package:campus_market/Counters/totalMoney.dart';
import 'package:campus_market/components/constants.dart';
import 'package:campus_market/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late double totalAmount;
  List allData = [];

  @override
  void initState() {
    super.initState();

    totalAmount = 0;
    Provider.of<TotalAmount>(context, listen: false).display(0);
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

    // print(allData[0]["price"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (EcommerceApp.sharedPreferences
                  ?.getStringList(EcommerceApp.userCartList)
                  ?.length ==
              1) {
            Fluttertoast.showToast(msg: "Your Cart is Empty");
          } else {
            // Route route = MaterialPageRoute(
            //     builder: (c) => Address(totalAmount: totalAmount));
            // Navigator. push(context, route);
          }
        },
        label: Text("Check Out"),
        backgroundColor: Colors.blueAccent,
        icon: Icon(Icons.navigate_next),
      ),
      appBar: AppBar(),
      //drawer: MyDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Consumer2<TotalAmount, CartItemCounter>(
              builder: (context, amountProvider, cartProvider, c) {
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: cartProvider.count == 0
                        ? Container()
                        : Text(
                            "Total Amount: Ghc ${amountProvider.totalAmount.toString()}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500),
                          ),
                  ),
                );
              },
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: EcommerceApp.firestore
                ?.collection("products")
                .where("shortInfo",
                    whereIn: EcommerceApp.sharedPreferences
                        ?.getStringList(EcommerceApp.userCartList))
                .snapshots(),
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : snapshot.data?.docs.length == 0
                      ? beginBuildingCart()
                      : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              ItemModel model = ItemModel.fromJson(
                                  snapshot.data as Map<String, dynamic>);

                              if (index == 0) {
                                totalAmount = 0;
                                //totalAmount = model.price + totalAmount;
                                model.discount == null
                                    ? totalAmount = model.price! + totalAmount
                                    : totalAmount = (model.price! -
                                            (model.price! *
                                                (model.discount! * 0.01))) +
                                        totalAmount;
                              } else {
                                model.discount == null
                                    ? totalAmount = model.price! -
                                        (model.price! *
                                            (model.discount! * 0.01))
                                    : totalAmount;
                                //totalAmount = model.price + totalAmount;
                              }

                              if (snapshot.data?.docs.length == index) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((t) {
                                  Provider.of<TotalAmount>(context,
                                          listen: false)
                                      .display(totalAmount);
                                });
                              }

                              // return sourceInfo(model, context,
                              //     removeCartFunction: () =>
                              //         removeItemFromUserCart(model.shortInfo));
                            },
                            childCount: snapshot.hasData
                                ? snapshot.data?.docs.length
                                : 0,
                          ),
                        );
            },
          )
        ],
      ),
    );
  }

  beginBuildingCart() {
    return SliverToBoxAdapter(
        child: Card(
            color: Theme.of(context).primaryColor.withOpacity(0.5),
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

  removeItemFromUserCart(String shortInfoAsId) {
    List<String>? tempCartList = EcommerceApp.sharedPreferences
        ?.getStringList(EcommerceApp.userCartList);
    tempCartList?.remove(shortInfoAsId);

    print(EcommerceApp.firestore
        ?.collection(EcommerceApp.collectionUser)
        .doc(EcommerceApp.sharedPreferences?.getString(EcommerceApp.userUID)));
    EcommerceApp.firestore
        ?.collection(EcommerceApp.collectionUser)
        .doc(EcommerceApp.sharedPreferences?.getString(EcommerceApp.userUID))
        .update({
      EcommerceApp.userCartList: tempCartList,
    }).then((v) {
      // Fluttertoast.showToast(msg: "Item deleted from Cart Successfully.");

      // EcommerceApp.sharedPreferences
      //     .setStringList(EcommerceApp.userCartList, tempCartList);
      // Provider.of<CartItemCounter>(context, listen: false).displayResult();
      // totalAmount = 0;
    });
    Fluttertoast.showToast(msg: "Item deleted from Cart Successfully.");

    EcommerceApp.sharedPreferences
        ?.setStringList(EcommerceApp.userCartList, tempCartList!);
    Provider.of<CartItemCounter>(context, listen: false).displayResult();
    totalAmount = 0;
  }
}
