import 'package:campus_market/productdetails.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size productSize = MediaQuery.of(context).size;
    var discount = 20;
    var price = 200;
    return Container(
      child: InkWell(
          onTap: () {
            Route route = MaterialPageRoute(
                builder: (c) => ProductPage());
            Navigator. push(context, route);
            
          },
          splashColor: Colors.blue,

          child: Padding(
          
            padding: EdgeInsets.symmetric(
                horizontal:productSize.width <= 320 ? productSize.width * 0.0168 : 12, vertical:productSize.width <= 320 ? productSize.width * 0.0168 : 5),
            child: Container(
              
                decoration:
                    BoxDecoration(//border: Border.all(color: Colors.black)
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
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
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: Image.asset("assets/adidas.jpg")
                                      .image,
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
                                  "Adidas Shorts",
                                  style: TextStyle(
                                      color: Colors.black,
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
                                      "Men's shorts on sale |adidas",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 12),
                                    )
                                  : Text(
                                      "Men's shorts on sale |adidas",
                                      // model.shortInfo.sentenceCase,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 12),
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
                                color: Colors.blue,
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
                                        discount == null
                                            ? "50%"
                                            : discount.toString() + "%",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      Text(
                                        "OFF",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal),
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
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        discount == null
                                            ? (price * 2).toString()
                                            : (price).toString(),
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
                                            color: Colors.black,
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
                                        discount == null
                                            ? price.toString() + ".00"
                                            : (price -
                                                        (price *
                                                            (discount *
                                                                0.01)))
                                                    .toString() +
                                                "0",
                                        style: TextStyle(
                                          color: Colors.black,
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
                                  icon: Icon(Icons.add_shopping_cart,
                                      color: Colors.blueAccent),
                                  onPressed: () {
                                    // checkItemInCart(model.shortInfo, quantity,
                                    //     size, model, context);
                                  })
                              
                                ),
                        
                       
                      ],
                    ),
                  ),
                ])),
          )),
    );
  }
}
