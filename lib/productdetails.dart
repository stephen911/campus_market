import 'package:campus_market/appbar.dart';
import 'package:campus_market/model/user_model.dart';
import 'package:campus_market/providers/theme_provider.dart';
import 'package:campus_market/screens/cart/cart.dart';
import 'package:campus_market/screens/cart/cart_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  ProductPage({
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
  }) : super(key: key);
  String img;
  int discount;
  String productId;

  double price;
  String title;
  String description;
  String sellerUid;
  String brand;
  String category;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final _auth = FirebaseAuth.instance;

  List productSizes = ["S", "M", "L", "XL", "XXL"];
  String _selectedProductSize = "S";
  int quantityOfItems = 1;
  List allData = [];
  bool flagDetails = false;

  // var title = "Adidas Shorts";
  // var longdescription =
  //     "Keep it classic with the adidas 3 stripes shorts in black or blue including the iconic adidas 3 stripe logo down the side or for the athletes";
  // var discount = 20;
  // var price = 200;

  void show() {
    setState(() {});
  }

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
      allData = emtdata;
    });

    // print(allData[0]["price"]);
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
      'quantityOfItems': quantityOfItems,
      'size': _selectedProductSize,
      'productId': widget.productId,
      'discount': widget.discount,
      'location': "",
      'date': DateTime.now(),
    });

    Fluttertoast.showToast(msg: " product added to cart:) ");
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    //Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
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
                    // getData();

                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CartScreen()));
                  },
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                  ))
            ],
          ),
          //drawer: MyDrawer(),
          body: ListView(children: [
            Container(
              padding: EdgeInsets.all(8.0),
              width: MediaQuery.of(context).size.width,
              color: themeChange.darkTheme ? Colors.black : Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Center(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: Image.network(widget.img).image,
                                        fit: BoxFit.cover)),
                                width: MediaQuery.of(context).size.width - 20,
                                height:
                                    MediaQuery.of(context).size.width * 0.99)),
                      ),
                      Container(
                        color: Colors.grey[300],
                        child: SizedBox(
                          height: 1.0,
                          width: double.infinity,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(20.0),
                    child: Center(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: TextStyle(
                                color: themeChange.darkTheme
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              widget.description,
                              style: TextStyle(
                                color: themeChange.darkTheme
                                    ? Colors.grey
                                    : Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text("Select Size",
                                style: TextStyle(
                                    color: themeChange.darkTheme
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18)),
                            SizedBox(
                              height: 10.0,
                            ),
                            ProductSize(
                              productSizes: productSizes,
                              onSelected: (size) {
                                _selectedProductSize = size;
                              },
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text("Quantity",
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 17,
                                  color: themeChange.darkTheme
                                      ? Colors.white
                                      : Colors.black,
                                )),
                            SizedBox(
                              height: 10.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 25),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  width: 120,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: FlatButton(
                                          padding: EdgeInsets.all(0),
                                          onPressed: () {
                                            setState(() {
                                              if (quantityOfItems > 1) {
                                                quantityOfItems--;
                                              }
                                            });
                                          },
                                          child: Text(
                                            "-",
                                            style: TextStyle(
                                                color: themeChange.darkTheme
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        quantityOfItems.toString(),
                                        style: TextStyle(
                                            color: themeChange.darkTheme
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20),
                                      ),
                                      SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: FlatButton(
                                          padding: EdgeInsets.all(0),
                                          onPressed: () {
                                            setState(() {
                                              quantityOfItems++;
                                              print(quantityOfItems);
                                            });
                                          },
                                          child: Text(
                                            "+",
                                            style: TextStyle(
                                                color: themeChange.darkTheme
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  widget.discount == 0
                                      ? "Ghs " +
                                          (quantityOfItems * widget.price)
                                              .toString()
                                      : "Ghs " +
                                          ((widget.price -
                                                      (widget.price *
                                                          (widget.discount *
                                                              0.01))) *
                                                  quantityOfItems)
                                              .toString(),
                                  style: TextStyle(
                                      color: themeChange.darkTheme
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                SizedBox(height: 10),
                                quantityOfItems >= 2
                                    ? Text(
                                        widget.discount == 0
                                            ? "Unit Price Ghs " +
                                                (widget.price).toString()
                                            : "Unit Price Ghs " +
                                                (widget.price -
                                                        (widget.price *
                                                            (widget.discount *
                                                                0.01)))
                                                    .toString(),
                                        style: TextStyle(
                                            color: themeChange.darkTheme
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )
                                    : Container(),
                              ],
                            )
                          ]),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          // postDetailsToFirestore();
                          checkItemInCart();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Center(
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  height: 370,
                                  child: AlertDialog(
                                    content: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'Product added to cart',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                            fontSize: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Image.asset(
                                          'assets/images/correct.png',
                                          height: 90,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          'You can now purchase by opening your cart. Thank you',
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      GestureDetector(
                                        child: const Text(
                                          'OK',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                            fontSize: 20,
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              gradient: new LinearGradient(
                                  begin: const FractionalOffset(0, 0),
                                  end: const FractionalOffset(1, 0),
                                  stops: [0, 1],
                                  tileMode: TileMode.clamp,
                                  colors: [
                                    // Color(0xFF0731aa),
                                    // Color(0xFF47f7ed),
                                    Colors.blue,
                                    Colors.green
                                  ])),
                          width: MediaQuery.of(context).size.width - 40.0,
                          height: 50.0,
                          child: Center(
                            child: Text("Add to Cart",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ])),
    );
  }

  void checkItemInCart() {
    getData();

    // for (int i = 0; i < allData.length; i++) {
    //   print(allData[i]['productId']);
    //   print(widget.productId);

    //   if (allData[i]['productId'] == widget.productId) {
    //     updateCart();
    //     Fluttertoast.showToast(msg: "product updated successfully");
    //   } else {
    //     addtoCart();
    //   }
    // }
    if (allData.length != 0) {
      for (int i = 0; i < allData.length; i++) {
        print(allData[i]['productId']);
        print(allData.length);

        print(widget.productId);

        if (allData[i]['productId'] == widget.productId) {
          // print(_cart);
          flagDetails = false;
          // break;
          // Fluttertoast.showToast(msg: "Product already in cart");
          
        } else {
          flagDetails = true;
        }
      }
      if (flagDetails) {
        addtoCart();
        // print(allDataProductCard);
        Fluttertoast.showToast(msg: "product added to cart");

      }else{
        updateCart();
        Fluttertoast.showToast(msg: "product updated successfully");

      }
    } else {
      addtoCart();
    }
  }
  

  void updateCart() {
    for (int i = 0; i < allData.length; i++) {
      if (allData[i]['uid'] == user!.uid) {
        final docUser = FirebaseFirestore.instance
            .collection('carts')
            .doc(allData[i]['parentId']);
        // updating the specific fields

        docUser.update({
          'quantityOfItems': quantityOfItems,
          'size': _selectedProductSize,
        });
      }
    }
  }

  void addtoCart() {
    postDetailsToFirestore();
  }
}

const boldTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
const largeTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 20);

class ProductSize extends StatefulWidget {
  final List productSizes;
  final Function(String) onSelected;
  ProductSize({required this.productSizes, required this.onSelected});

  @override
  _ProductSizeState createState() => _ProductSizeState();
}

class _ProductSizeState extends State<ProductSize> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 0,
      ),
      child: Row(
        children: [
          for (var i = 0; i < widget.productSizes.length; i++)
            GestureDetector(
              onTap: () {
                widget.onSelected("${widget.productSizes[i]}");
                setState(() {
                  _selected = i;
                });
              },
              child: Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                  color: _selected == i
                      ? Theme.of(context).accentColor
                      : Color(0xFFDCDCDC),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                  right: 8.0,
                ),
                child: Text(
                  "${widget.productSizes[i]}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: _selected == i ? Colors.white : Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
