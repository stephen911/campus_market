import 'package:cached_network_image/cached_network_image.dart';
import 'package:campus_market/Counters/cartitemcounter.dart';
import 'package:campus_market/components/constants.dart';
import 'package:campus_market/model/user_model.dart';
import 'package:campus_market/productCard.dart';
import 'package:campus_market/productdetails.dart';
import 'package:campus_market/providers/theme_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  CartProduct({
    Key? key,
    required this.description,
    required this.productId,
    required this.discount,
    required this.img,
    required this.price,
    required this.title,
    required this.sellerUid,
    required this.brand,
    required this.category,
    required this.quantity,
  }) : super(key: key);
  String img;
  int discount;
  double price;
  String title;
  String description;
  String sellerUid;
  String brand;
  String category;
  String quantity;
  String productId;

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  List allDataCard = [];
  bool flagDelete = false;
  String parentId = "";
  String parent = "";
  int index = 0;

  User? user = FirebaseAuth.instance.currentUser;

  void initState() {
    super.initState();
    getData();

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
      allDataCard = emtdata;
    });

    // print(allDataCard[0]["price"]);
  }

  @override
  Widget build(BuildContext context) {
    Size productSize = MediaQuery.of(context).size;
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal:
                productSize.width <= 320 ? productSize.width * 0.0168 : 1,
            vertical:
                productSize.width <= 320 ? productSize.width * 0.0168 : 1),
        child: Container(
            decoration: BoxDecoration(
              //border: Border.all(color: Colors.black)
              borderRadius: BorderRadius.circular(6),
              color: themeChange.darkTheme ? Colors.black : Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    offset: Offset(0, 0), color: Colors.black26, blurRadius: 2),
              ],
            ),
            height:
                (productSize.width <= 320 ? productSize.height * 0.244 : 90),
            width: double.infinity,
            child: Row(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CachedNetworkImage(
                  fadeInCurve: Curves.bounceInOut,
                  imageUrl: widget.img,
                  imageBuilder: (context, imageProvider) {
                    return new Container(
                      width: 125,
                      height: 190,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      )),
                    );
                  },
                  placeholder: (_, url) {
                    return Center(
                        widthFactor: 3.5,
                        child: new CupertinoActivityIndicator());
                  },
                  errorWidget: (context, url, error) {
                    return Center(
                        widthFactor: 1.5,
                        child: new Icon(Icons.error, color: Colors.grey));
                  },
                  height: MediaQuery.of(context).size.height * 0.30,
                  width: MediaQuery.of(context).size.width * 0.30,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: (productSize.width <= 320
                    ? productSize.width * 0.004
                    : 10), //10
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: (productSize.width <= 320
                          ? productSize.width * 0.014
                          : 5), //5
                    ),
                    Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Text(
                              widget.title,
                              style: TextStyle(
                                  color: themeChange.darkTheme
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: (productSize.width <= 320
                          ? productSize.width * 0.014
                          : 5), //5
                    ),
                    Container(
                        child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: productSize.width <= 320
                              ? Text(
                                  "Quantity: " + widget.quantity,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 12,
                                  ),
                                )
                              : Text(
                                  "Quantity: " + widget.quantity,
                                  // model.shortInfo.sentenceCase,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: themeChange.darkTheme
                                          ? Colors.grey[300]
                                          : Colors.black,
                                      fontSize: 13),
                                ),
                        ),
                      ],
                    )),
                    SizedBox(
                      height: (productSize.width <= 320
                          ? productSize.width * 0.020
                          : 7), //7
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Row(
                                children: [
                                  Text(
                                    r"Price: ",
                                    style: TextStyle(
                                        color: themeChange.darkTheme
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Text(
                                    "Ghc ",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    widget.discount == 0
                                        ? widget.price.toString()
                                        : (widget.price -
                                                (widget.price *
                                                    (widget.discount * 0.01)))
                                            .toStringAsFixed(2),
                                    style: TextStyle(
                                      color: themeChange.darkTheme
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Flexible(child: Container()),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {
                    // for (int i = 0; i < allDataCard.length; i++) {
                    //   if (allDataCard[i]['uid'] == user!.uid &&
                    //       allDataCard[i]['productId'] == widget.productId) {
                    //     flagDelete = true;
                    //     parentId = allDataCard[i]['parentId'];
                    //     setState(() {
                    //       parent = parentId;
                    //       index = i;
                    //     });
                    //   }
                    // }
                    // if (flagDelete) {
                    //   final collection =
                    //       FirebaseFirestore.instance.collection('carts');
                    //   collection
                    //       .doc(parent) // <-- Doc ID to be deleted.
                    //       .delete() // <-- Delete
                    //       .then((_) => print('Deleted'))
                    //       .catchError(
                    //           (error) => print('Delete failed: $error'));
                    //   setState(() {
                    //     allDataCard.removeAt(index);
                    //     getData();
                    //   });
                      Fluttertoast.showToast(msg:" slide to delete from cart" );
                    //   // Fluttertoast.show("delete successfully");
                    //   // allDataCard.removeAt(index);
                    //   // SnackBar(
                    //   //     content: Text(allDataCard[index]["title"].toString() +
                    //   //         " has been deleted"));
                    // }
                  },
                  icon: Icon(
                    Icons.delete_sweep_rounded,
                    size: 30,
                    color: Colors.red,
                  ))
            ])),
      ),
    );
  }
}
