import 'package:cached_network_image/cached_network_image.dart';
import 'package:campus_market/Counters/cartitemcounter.dart';
import 'package:campus_market/components/constants.dart';
import 'package:campus_market/components/shared_preferences.dart';
import 'package:campus_market/model/user_model.dart';
import 'package:campus_market/productdetails.dart';
import 'package:campus_market/providers/theme_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductCard extends StatefulWidget {
  ProductCard({
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
    // this.counter,
  }) : super(key: key);
  String img;
  String productId;

  int discount;
  double price;
  String title;
  String description;
  String sellerUid;
  String brand;
  String category;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

User? user = FirebaseAuth.instance.currentUser;
UserModel loggedInUser = UserModel();
final _auth = FirebaseAuth.instance;
List allDataProductCard = [];
bool flag = false;
int counter = 0;

class _ProductCardState extends State<ProductCard> {
  void initState() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {
        getData();
      });
    });
    super.initState();
  }

  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('carts');
  Future<void> getData() async {
    QuerySnapshot querySnapshot = await _collectionRef.get();

    List emtdata = querySnapshot.docs.map((doc) => doc.data()).toList();
    setState(() {
      allDataProductCard = emtdata;
    });

    // print(allDataProductCard[0]["price"]);
  }

  postDetailsToFirestore() async {
    //   // calling our firestore
    //   // calling our loan model
    //   // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    final ref = FirebaseFirestore.instance.collection("carts").doc();

    await ref.set({
      'uid': user!.uid,
      'productFile': widget.img,
      'sellerUid': widget.sellerUid,
      'title': widget.title,
      'description': widget.description,
      'brand': widget.brand,
      'parentId': ref.id,
      'category': widget.category,
      'price': widget.price,
      'name': loggedInUser.name.toString(),
      'phone': loggedInUser.phone.toString(),
      'email': loggedInUser.phone.toString(),
      'quantityOfItems': 1,
      'size': "M",
      'productId': widget.productId,
      'discount': widget.discount,
      'location': "",
      'date': DateTime.now(),
    });

    Fluttertoast.showToast(msg: " product added to cart:) ");
  }

  @override
  Widget build(BuildContext context) {
    Size productSize = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return Container(
      child: InkWell(
          onTap: () {
            Route route = MaterialPageRoute(
                builder: (c) => ProductPage(
                      productId: widget.productId,
                      brand: widget.brand,
                      category: widget.category,
                      sellerUid: widget.sellerUid,
                      discount: widget.discount,
                      img: widget.img,
                      price: widget.price,
                      title: widget.title,
                      description: widget.description,
                    ));
            Navigator.push(context, route);
          },
          splashColor: Colors.blue,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal:
                    productSize.width <= 320 ? productSize.width * 0.0168 : 12,
                vertical:
                    productSize.width <= 320 ? productSize.width * 0.0168 : 5),
            child: Container(
                decoration: BoxDecoration(
                  //border: Border.all(color: Colors.black)
                  borderRadius: BorderRadius.circular(6),
                  color: themeChange.darkTheme ? Colors.black : Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        offset: Offset(0, 0),
                        color: Colors.black26,
                        blurRadius: 2),
                  ],
                ),
                height: (productSize.width <= 320
                    ? productSize.height * 0.244
                    : 141),
                width: MediaQuery.of(context).size.width -
                    (productSize.width * 0.014),
                child: Row(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      fadeInCurve: Curves.bounceInOut,
                      imageUrl: widget.img,
                      imageBuilder: (context, imageProvider) {
                        return new Container(
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
                                      widget.description,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 12,
                                      ),
                                    )
                                  : Text(
                                      widget.description,
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
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: themeChange.darkTheme
                                    ? Colors.red
                                    : Colors.blueAccent,
                              ),
                              alignment: Alignment.topLeft,
                              width: (productSize.width <= 320
                                  ? productSize.width * 0.111
                                  : 40), //40
                              height: (productSize.width <= 320
                                  ? productSize.width * 0.12
                                  : 43), //43
                              child: Center(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        widget.discount == null
                                            ? ""
                                            : widget.discount.toString() + "%",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: themeChange.darkTheme
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        widget.discount != null ? "OFF" : "",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: themeChange.darkTheme
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                            SizedBox(
                                width: (productSize.width <= 320
                                    ? productSize.width * 0.004
                                    : 10)), //10
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 0),
                                  child: Row(
                                    children: [
                                      Text(
                                        r"Original Price: Ghc ",
                                        style: TextStyle(
                                            color: themeChange.darkTheme
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        widget.discount == null
                                            ? (widget.price * 2).toString()
                                            : (widget.price).toString(),
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15,
                                            decoration:
                                                TextDecoration.lineThrough),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        r"New Price: ",
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
                                                        (widget.discount *
                                                            0.01)))
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
                        //future

                        Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                                icon: Icon(
                                  Icons.add_shopping_cart,
                                  color: themeChange.darkTheme
                                      ? Colors.grey[400]
                                      : Colors.blueAccent,
                                ),
                                onPressed: () {
                                  checkItemInCart();
                                  // addtoCart();
                                })),
                      ],
                    ),
                  ),
                ])),
          )),
    );
  }

  void checkItemInCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //   List<String> getProductId(){
    //   String value = "";
    //   for(int i = 0; i < allDataProducts.length; i++){
    //     value = allDataProducts[i]["productId"];
    //     productId.add(value);
    //     print(value);
    //     print(32);
    //   }
    //   //  getProduct = alldata;
    //   return productId;
    // }
    getData();
    // int lenght = 0;
    int lenght = prefs.getStringList('cartList')!.length;

    List<String>? productId = prefs.getStringList('cartList');

    if (  lenght != 0) {
      print(lenght);

      for (int i = 0; i < lenght; i++) {
        // print(allDataProductCard[i]['productId']);
        // print(allDataProductCard.length);

        print(widget.productId);

        // print(allDataProductCard[i]['productId'] + "==" +  widget.productId);
          print(prefs.getStringList("cartList")![i]);


        if (prefs.getStringList("cartList")![i] == widget.productId) {
          flag = false;
          // break;
          Fluttertoast.showToast(msg: "Product already in cart");
        } else {
          flag = true;
        }
      }
      if (flag) {
        productId!.add(widget.productId);
        prefs.setStringList("cartList", productId);
        addtoCart();

        // print(allDataProductCard);
      }
    } else {
      productId!.add(widget.productId);
      prefs.setStringList("cartList", productId);
      addtoCart();
    }
  }

  getListCart(String userCartList, List value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // prefs.setStringList('cartList', _cart);
  }

  Box counterTheme = Hive.box("CartCounter");

  void addtoCart() {
    // print(_cart);

    // getListCart(EcommerceApp.userCartList, _cart);
    postDetailsToFirestore();
    counter = counter + 1;
    counterTheme.put("counter", counter);
  }
}
