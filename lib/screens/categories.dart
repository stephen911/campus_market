import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
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
        body: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
              width: double.infinity,
              height: 30,
              decoration: BoxDecoration(color: Colors.red),
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
    ));
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
        CartItem(
          name: "Computing",
          image: "assets/Laptop-computer.jpg",
          onTapped: () {},
        ),
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
    return GestureDetector(
      onTap: onTapped,
      child: Container(
        decoration: BoxDecoration(
            //border: Border.all(width: 1)
            ),
        margin: EdgeInsets.all(3),
        padding: EdgeInsets.all(5),
        height: 120,
        width: MediaQuery.of(context).size.width * 0.25 - 6,
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
                fontSize: 13, color: Colors.black, fontWeight: FontWeight.w600),
          )
        ]),
      ),
    );
  }
}
