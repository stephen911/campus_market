import 'package:campus_market/appbar.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List productSizes = ["S", "M", "L", "XL", "XXL"];
  String _selectedProductSize = "S";
  int quantityOfItems = 1;
  var title = "Adidas Shorts";
  var longdescription =
      "Keep it classic with the adidas 3 stripes shorts in black or blue including the iconic adidas 3 stripe logo down the side or for the athletes";
  var discount = 20;
  var price = 200;

  void show() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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
                Icons.notifications,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.perm_contact_calendar,
                color: Colors.black,
              ))
        ],
      ),
          //drawer: MyDrawer(),
          body: ListView(children: [
        Container(
          padding: EdgeInsets.all(8.0),
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
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
                                  image: Image.asset("assets/adidas.jpg")
                                      .image,
                                  fit: BoxFit.cover)),
                          width: MediaQuery.of(context).size.width - 20,
                          height: MediaQuery.of(context).size.width * 0.99)),
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
                          title,
                          style: boldTextStyle,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          longdescription,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text("Select Size",
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 17)),
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
                                fontWeight: FontWeight.w800, fontSize: 17)),
                        SizedBox(
                          height: 10.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 25),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey, width: 2),
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
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    quantityOfItems.toString(),
                                    style: TextStyle(
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
                              discount == null
                                  ? "Ghs " +
                                      (quantityOfItems * price)
                                          .toString() +
                                      ".00"
                                  : "Ghs " +
                                      ((price -
                                                  (price *
                                                      (discount *
                                                          0.01))) *
                                              quantityOfItems)
                                          .toString() +
                                      "0",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            SizedBox(height: 10),
                            quantityOfItems >= 2
                                ? Text(
                                    discount == null
                                        ? "Unit Price Ghs " +
                                            (price)
                                                .toString() +
                                            ".00"
                                        : "Unit Price Ghs " +
                                            (price -
                                                    (price *
                                                        (discount *
                                                            0.01)))
                                                .toString() +
                                            "0",
                                    style: TextStyle(
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
                    onTap: () {},
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