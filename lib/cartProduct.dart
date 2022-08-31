import 'package:campus_market/Counters/cartitemcounter.dart';
import 'package:campus_market/components/constants.dart';
import 'package:campus_market/model/user_model.dart';
import 'package:campus_market/productdetails.dart';
import 'package:campus_market/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatelessWidget {
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
                      offset: Offset(0, 0),
                      color: Colors.black26,
                      blurRadius: 2),
                ],
              ),
              height: (productSize.width <= 320
                  ? productSize.height * 0.244
                  : 90),
              width:  double.infinity,
              child: Row(children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: img == null
                        ? CircularProgressIndicator()
                        : Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: Image.network(img).image,
                                    fit: BoxFit.cover)),
                            width: 125,
                            height: 190)),
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
                                title,
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
                                ? Text("Quantity: " +
                                  quantity,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 12,
                                    ),
                                  )
                                : Text("Quantity: " +
                                    quantity,
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
                                      discount == 0
                                          ? price.toString()
                                          : (price -
                                                  (price * (discount * 0.01)))
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
                IconButton(onPressed: (){}, icon: Icon(Icons.delete_forever, color: Colors.red,))
              ])),
        ),
      
    );
  }
}
