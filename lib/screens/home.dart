import 'package:campus_market/productCard.dart';
import 'package:campus_market/screens/categories/categories.dart';
import 'package:campus_market/screens/categories/categoryCard.dart';
import 'package:campus_market/screens/notification/notifications.dart';
import 'package:campus_market/screens/product_fetch.dart';
import 'package:campus_market/sign_up/sign_up_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;

  List Navbody = [
    // this isthe content of the home page
    HomePageContent(),
    /////the content of the sign page page
    SignUpScreen(),
    //////the content of the categories page
    Categories(),
    //////the content of the notification page
    Notifications(),
  ];

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
      bottomNavigationBar: BottomNavyBar(
        animationDuration: Duration(milliseconds: 5),
        // backgroundColor: Colors.black,
        curve: Curves.elasticIn,
        selectedIndex: currentIndex,
        onItemSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
            activeColor: Colors.blueAccent,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.person),
            title: Text("profile"),
            activeColor: Colors.deepOrangeAccent,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.category),
            title: Text("categories"),
            activeColor: Colors.redAccent,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.notifications),
            title: Text("notification"),
            activeColor: Colors.green,
            inactiveColor: Colors.black,
          ),
        ],
      ),
      body: Navbody[currentIndex],
    );
  }
}

class HomePageContent extends StatefulWidget {
  const HomePageContent({Key? key}) : super(key: key);

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  List allData = [];
  static List bannerAdSlider = [
    "assets/banner1.jpg",
    "assets/banner2.jpg",
    "assets/banner3.jpg",
    "assets/banner4.jpg",
    "assets/banner5.jpg",
    "assets/banner6.jpg",
    "assets/banner7.jpg",
    "assets/banner8.jpg"
  ];
  // var discount = 20;
  // var price = 200;
  // var description = "Men's shorts on sale |adidas";
  // var img = "assets/adidas.jpg";
  // var title = "Adidas Shorts";

  List category_list = [
    {"title": "Sneakers", "img": "assets/cat.png", "tag": "popular", "price" : "300"},
    // {"title": "Shorts", "img": "assets/adidas.jpg"},
    {"title": "Sneakers", "img": "assets/cat.png", "tag": "new", "price" : "300"},
    {"title": "Shorts", "img": "assets/adidas.jpg", "tag": "upcoming", "price" : "300"},
    {"title": "Shorts", "img": "assets/adidas.jpg", "tag": "new", "price" : "300"},
    {"title": "Sneakers", "img": "assets/cat.png", "tag": "recommended", "price" : "300"},
    {"title": "Sneakers", "img": "assets/cat.png", "tag": "best selling", "price" : "300"},
    {"title": "Sneakers", "img": "assets/cat.png", "tag": "trending", "price" : "300"},
  ];

  List myList = [
    {
      "discount": 20,
      "price": 200,
      "img": "assets/adidas.jpg",
      "title": "Adidas Shorts",
      "description": "Men's shorts on sale |adidas",
    },
    {
      "discount": 40,
      "price": 200,
      "img": "assets/images/suit.jpg",
      "title": "official suit",
      "description": "Men's official wear on sale |Turkey suit",
    },
  ];
  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('products');
  Future<void> getData() async {
    QuerySnapshot querySnapshot = await _collectionRef.get();
    
    List emtdata = querySnapshot.docs.map((doc) => doc.data()).toList();
    setState(() {
      allData = emtdata;
    });
    
    // print(allData![0]["status"]);
  }

  void initState() {
    super.initState();
    setState(() {
    getData();
      
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final themeChange = Provider.of<DarkThemeProvider>(context);

    /// big Card widget on home page
    Widget BigCard({
      required String img,
      required String title,
      required Color color,
    }) {
      return Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              alignment: Alignment.center,
              // color: Colors.red,
              height: 180.0,
              width: size.width,
              margin: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            width: size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.0),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    img,
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: 120,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 35,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      );
    }

    final controller = ScrollController();
    double offset = 0;

    void onScroll() {
      setState(() {
        offset = (controller.hasClients) ? controller.offset : 0;
      });
    }

    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      controller.addListener(onScroll);
    }

    @override
    void dispose() {
      // TODO: implement dispose
      controller.dispose();
      super.dispose();
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: controller,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 5),
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    // color: Colors.white.withOpacity(0.2),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: TextField(
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            /* Clear the search field */
                          },
                        ),
                        hintText: 'Search for products',
                        border: InputBorder.none),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),

              CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 20 / 6,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  scrollPhysics: BouncingScrollPhysics(),
                ),
                items: bannerAdSlider.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return GestureDetector(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          //height: 500,
                          margin: EdgeInsets.symmetric(horizontal: 3.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image(
                              image: AssetImage(i),
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                        ),
                        onTap: () {
                          print(i);
                        },
                      );
                    },
                  );
                }).toList(),
              ),
              SizedBox(
                height: 10,
              ),

              BigCard(
                color: themeChange.darkTheme ? Colors.white : Colors.white,
                img: "assets/images/restaurant.jpg",
                title: "Restaurant",
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                margin: EdgeInsets.only(
                  left: 12,
                  right: 12,
                ),
                decoration: BoxDecoration(
                  color: themeChange.darkTheme ? Colors.black : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "See more of the products below",
                      style: TextStyle(
                        fontSize: 16,
                        color: themeChange.darkTheme
                            ? Colors.white
                            : Colors.grey[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        //TODO: move to a page where products are displayed more
                      },
                      icon: Icon(Icons.arrow_forward,
                          color: themeChange.darkTheme
                              ? Colors.white
                              : Colors.grey[800]),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "Explore",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "All",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    for (int i = 0; i < category_list.length; i++)
                      CategoryModel(
                        price: category_list[i]["price"],
                        img: category_list[i]["img"],
                        tag: category_list[i]["tag"],
                        title: category_list[i]["title"],
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              for (int i = 0; i < allData.length; i++)
              if (allData[i]["status"] == "approved")
                ProductCard(
                  description: allData[i]["description"],
                  discount: allData[i]["discount"],
                  img: allData[i]["productFile"],
                  price: allData[i]["price"],
                  title: allData[i]["title"],
                ),
              SizedBox(
                height: 10,
              ),

              BigCard(
                color: themeChange.darkTheme ? Colors.black : Colors.white,
                img: "assets/images/supermarket.jpg",
                title: "Supermarket",
              ),
              SizedBox(
                height: 20,
              ),
              BigCard(
                color: themeChange.darkTheme ? Colors.black : Colors.white,
                img: "assets/images/phone_accessories1.jpg",
                title: "Phones & \nAccessories",
              ),
              // ProductCard(),
              // ProductCard(),
              // ProductCard(),
              // ProductCard(),
            ],
          ),
        ),
      ),
    );
  }
}
