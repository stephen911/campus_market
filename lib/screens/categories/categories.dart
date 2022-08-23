import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  Widget SideCard({
    required String title,
    required VoidCallback ontap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: ontap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Divider(height: 2,),
      ],
    );
  }

    
    @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black12,
        body: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /////////category listing left side /////////

            SingleChildScrollView(
              child: Container(
                color: themeChange.darkTheme ? Colors.black : Colors.white,
                padding: EdgeInsets.only(
                  top: 5,
                  left: 5,
                ),
                width: size.width * 0.25,
                child: Column( 
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  SideCard(
                    title: "Groceries",
                    ontap: () {},
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SideCard(
                    title: "Laptops",
                    ontap: () {},
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SideCard(
                    title: "Phones & Accessories",
                    ontap: () {},
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SideCard(
                    title: "Hostels",
                    ontap: () {},
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SideCard(
                    title: "Medical Equipments",
                    ontap: () {},
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SideCard(
                    title: "Health & Beauty",
                    ontap: () {},
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SideCard(
                    title: "Sports",
                    ontap: () {},
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SideCard(
                    title: "Women's Fashion",
                    ontap: () {},
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SideCard(
                    title: "Furniture",
                    ontap: () {},
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SideCard(
                    title: "Electronics",
                    ontap: () {},
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SideCard(
                    title: "Men's Fashion",
                    ontap: () {},
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SideCard(
                    title: "Kid's Fashion",
                    ontap: () {},
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SideCard(
                    title: "Home & Office",
                    ontap: () {},
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SideCard(
                    title: "Automobile",
                    ontap: () {},
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SideCard(
                    title: "Automobile",
                    ontap: () {},
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SideCard(
                    title: "Automobile",
                    ontap: () {},
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SideCard(
                    title: "Automobile",
                    ontap: () {},
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ]),
              ),
            ),
            SizedBox(
              width: 7,
            ),

            /////////category display right side /////////
            SingleChildScrollView(
              child: Container(
                color: themeChange.darkTheme ? Colors.black : Colors.white,
                width: size.width * 0.73,
                child: Column(
                  children: [
                    Container(
                        width: size.width * 0.75,
                        height: 30,
                        decoration: BoxDecoration(
                          color:
                              themeChange.darkTheme ? Colors.black : Colors.red,
                        ),
                        child: Center(
                            child: Text(
                          "Top Categories",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w900),
                        ))),
                    Items()
                  ],
                ),
              ),
            )
          ],
        ));
        
          @override
          Widget build(BuildContext context) {
            // TODO: implement build
            throw UnimplementedError();
          }
  }
}

class Items extends StatelessWidget {
  // Future<QuerySnapshot> docList;

  @override
  Widget build(BuildContext context) {

    return Wrap(
      alignment: WrapAlignment.start,
      children: [
        CartItem(
          name: "Groceries",
          image: "assets/groceries.jpg",
          onTapped: () {},
        ),
        CartItem(
          name: "Phones & Tablets",
          image: "assets/phones.jpg",
          onTapped: () {},
        ),
        CartItem(
          name: "Men's Fashion",
          image: "assets/mens.jpg",
          onTapped: () {},
        ),
        CartItem(
          name: "women's Fashion",
          image: "assets/women.jpg",
          onTapped: () {},
        ),
        CartItem(
          name: "Kid's Fashion",
          image: "assets/kids-fashion.jpg",
          onTapped: () {},
        ),
        CartItem(
          name: "Electronics",
          image: "assets/electronics.png",
          onTapped: () {},
        ),
        // CartItem(
        //   name: "Computing",
        //   image: "assets/Laptop-computer.jpg",
        //   onTapped: () {},
        // ),
        CartItem(
          name: "Home & Office",
          image: "assets/Home-and-Office.jpg",
          onTapped: () {},
        ),
        CartItem(
          name: "Kitchen & Dining",
          image: "assets/kitchen.jpg",
          onTapped: () {},
        ),
        CartItem(
          name: "Furniture",
          image: "assets/furniture.jpg",
          onTapped: () {},
        ),
        CartItem(
          name: "Health & Beauty",
          image: "assets/Health.jpg",
          onTapped: () {},
        ),
        CartItem(
          name: "Sports",
          image: "assets/sports.jpg",
          onTapped: () {},
        ),
        CartItem(
          name: "Automobile",
          image: "assets/automobile.jpg",
          onTapped: () {},
        ),
        CartItem(
          name: "Books",
          image: "assets/books.jpg",
          onTapped: () {},
        ),
      ],
    );
  }
}

class CartItems {
  String image;
  String name;
  CartItems({required this.image, required this.name});
}

class CartItem extends StatelessWidget {
  final String image;
  final String name;
  final VoidCallback onTapped;

  const CartItem(
      {Key? key,
      required this.image,
      required this.name,
      required this.onTapped})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);

    return GestureDetector(
      onTap: onTapped,
      child: Container(
        decoration: BoxDecoration(
            //border: Border.all(width: 1)
            ),
        margin: EdgeInsets.all(3),
        padding: EdgeInsets.all(5),
        height: 120,
        width: MediaQuery.of(context).size.width * 0.22,
        child: Column(children: [
          Container(
            height: 70,
            width: MediaQuery.of(context).size.width * 0.25 - 6,
            child: Image(
                image: AssetImage(
                    this.image == null ? "assets/email.png" : this.image),
                fit: BoxFit.fill),
          ),
          //Expanded(child: Container()),
          SizedBox(
            height: 5,
          ),
          Text(
            this.name == null ? "Category Name" : this.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 13,
                color: themeChange.darkTheme ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600),
          )
        ]),
      ),
    );
  }
}
