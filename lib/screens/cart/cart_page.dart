import 'package:campus_market/cartProduct.dart';
import 'package:campus_market/screens/cart/cart.dart';
import 'package:campus_market/screens/cart/confirm_order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

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
  String location = 'Null, Press Button';
  final _auth = FirebaseAuth.instance;

  String? Address = 'search';
  Position? position;
  bool checkLoc = false;

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

  check_permission() async {
    bool serviceEnabled;
    LocationPermission permission;
    var status = await Permission.location.status;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    var statusContact = await Permission.contacts.status;

    if (!serviceEnabled) {
      print("status is not enabled");
      // await Permission.location.request();
      await Geolocator.openLocationSettings();
    }

    getLoc();

    if (status.isDenied) {
      print("status is denied");
      await Permission.location.request();
    }

    if (status.isPermanentlyDenied) {
      print("status is denied permenantly");
      await Permission.location.request();
    }
    if (serviceEnabled && status.isGranted) {
      getLoc();
      ///// Navigate
      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ConfirmOrder()));
    } else {
      Fluttertoast.showToast(msg: "allow location permission to apply loan");
      Navigator.pop(context);
    }
  }

  Future<Position> _getGeoLocationPosition() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address =
        '${place.name}, ${place.street}, ${place.administrativeArea}, ${place.subAdministrativeArea} ,${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    User? user = FirebaseAuth.instance.currentUser;

    for (int i = 0; i < allData.length; i++) {
      if (allData[i]['uid'] == user!.uid) {
        final docUser = FirebaseFirestore.instance
            .collection('carts')
            .doc(allData[i]['parentId']);
        // updating the specific fields

        docUser.update({
          "location": Address,
        });
      }
    }

    Fluttertoast.showToast(msg: "location updated successfully");
  }

  Future<void> getLoc() async {
    position = await _getGeoLocationPosition();
    location = 'Lat: ${position!.latitude} , Long: ${position!.longitude}';
    GetAddressFromLatLong(position!);
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
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color.fromARGB(255, 247, 247, 247),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.feed,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => CartPage()));
              },
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          itemCount: allData.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: allData[index]["uid"] == user!.uid
                ? Dismissible(
      key: Key(allData[index]["productId"].toString()),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                allData.removeAt(index);
                SnackBar(content: Text(allData[index]["title"].toString() + " has been deleted"));
              });
            },
            secondaryBackground: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.delete_sweep_rounded, color: Colors.white,),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(15),

              )),
            background: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.delete_sweep_rounded, color: Colors.white,),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(15),

              )),
      
                  child: CartProduct(
                      description: allData[index]["description"].toString(),
                      productId: allData[index]["productId"].toString(),
                      discount: allData[index]["discount"],
                      img: allData[index]["productFile"].toString(),
                      price: allData[index]["price"],
                      title: allData[index]["title"].toString(),
                      sellerUid: allData[index]["sellerUid"].toString(),
                      brand: allData[index]["brand"].toString(),
                      category: allData[index]["category"].toString(),
                      quantity: allData[index]["quantityOfItems"].toString(),
                    ),
                )
                : beginBuildingCart(),
          ),
        ),
      ),
      bottomNavigationBar: CheckoutCard(
        total: total.toStringAsFixed(2),
        tap: check_permission,
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
}
