import 'dart:ffi';

import 'package:campus_market/orders/order.dart';
import 'package:campus_market/productCard.dart';
import 'package:campus_market/screens/cart/cart.dart';
import 'package:campus_market/screens/cart/cart_page.dart';
import 'package:campus_market/screens/categories/categories.dart';
import 'package:campus_market/screens/categories/categoryCard.dart';
import 'package:campus_market/screens/notification/notifications.dart';
import 'package:campus_market/screens/product_fetch.dart';
import 'package:campus_market/sign_up/sign_up_screen.dart';
import 'package:campus_market/widgets/loading.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    getData();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    getData();
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());
    // if(mounted)
    // setState(() {

    // });
    _refreshController.loadComplete();
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Widget callPage(int _selectedBar) {
    switch (_selectedBar) {
      case 0:
        return HomePageContent();
      case 1:
        return SignUpScreen();
      case 2:
        return Categories();
      case 3:
        return Notifications();

      default:
        return HomePageContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    void changePage(int index) {
      setState(() {
        currentIndex = index;
      });
    }

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
      body: this.callPage(this.currentIndex),
    );
  }
}

class HomePageContent extends StatefulWidget {
  const HomePageContent({Key? key}) : super(key: key);

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  List allDataProducts = [];
  bool isLoading = false;
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
    {
      "title": "Sneakers",
      "img": "assets/cat.png",
      "tag": "popular",
      "price": "300"
    },
    // {"title": "Shorts", "img": "assets/adidas.jpg"},
    {
      "title": "Sneakers",
      "img": "assets/cat.png",
      "tag": "new",
      "price": "300"
    },
    {
      "title": "Shorts",
      "img": "assets/adidas.jpg",
      "tag": "upcoming",
      "price": "300"
    },
    {
      "title": "Shorts",
      "img": "assets/adidas.jpg",
      "tag": "new",
      "price": "300"
    },
    {
      "title": "Sneakers",
      "img": "assets/cat.png",
      "tag": "recommended",
      "price": "300"
    },
    {
      "title": "Sneakers",
      "img": "assets/cat.png",
      "tag": "best selling",
      "price": "300"
    },
    {
      "title": "Sneakers",
      "img": "assets/cat.png",
      "tag": "trending",
      "price": "300"
    },
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

  Future<List<DocumentSnapshot>> getDatafire() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore
        .collection("products")
        // .where("Title", isEqualTo: "Solo")
        .get();
    return qn.docs;
  }

  CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('products');
  Future<void> getData() async {
    QuerySnapshot querySnapshot = await _collectionRef.get();

    List emtdata = querySnapshot.docs.map((doc) => doc.data()).toList();
    setState(() {
      allDataProducts = emtdata;
      isLoading = true;
    });

    // print(allDataProducts![0]["status"]);
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
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Color.fromARGB(255, 247, 247, 247),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => OrdersPage()));
              },
              icon: Icon(
                Icons.feed,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CartScreen()));
              },
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ))
        ],
      ),
      body: SafeArea(
        child: SmartRefresher(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          enablePullDown: true,
          enablePullUp: true,
          header: WaterDropHeader(),
          footer: CustomFooter(
            builder: (BuildContext context, mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = Text("pull up load");
              } else if (mode == LoadStatus.loading) {
                body = CupertinoActivityIndicator();
              } else if (mode == LoadStatus.failed) {
                body = Text("Load Failed!Click retry!");
              } else if (mode == LoadStatus.canLoading) {
                body = Text("release to load more");
              } else {
                body = Text("No more Data");
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: SingleChildScrollView(
            controller: controller,
            child: Column(
              children: [
                
ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: CachedNetworkImage(
                                          fadeInCurve: Curves.bounceInOut,
                                          imageUrl: icons[index],
                                          imageBuilder:
                                              (context, imageProvider) {
                                            return new Container(
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.fill)),
                                            );
                                          },
                                          placeholder: (_, url) {
                                            return Center(
                                                widthFactor: 3.5,
                                                child:
                                                    new CupertinoActivityIndicator());
                                          },
                                          errorWidget: (context, url, error) {
                                            return Center(
                                                widthFactor: 1.5,
                                                child: new Icon(Icons.error,
                                                    color: Colors.grey));
                                          },
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.30,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.30,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
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
                // FutureBuilder(
                //     future: getDatafire(),
                //     builder: (_, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
                //       if (snapshot.connectionState == ConnectionState.waiting) {
                //         return Padding(
                //           padding: const EdgeInsets.only(
                //             top: 50,
                //           ),
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //             children: <Widget>[
                //               Center(
                //                 child: Text(""),
                //                 // child: SpinKitCircle(
                //                 //   color: Color.fromRGBO(91, 74, 127, 10),
                //                 //   size: 50.0,
                //                 // ),
                //               ),
                //             ],
                //           ),
                //         );
                //       } else {
                //         return ListView.builder(
                //             itemCount: snapshot.data!.length,
                //             itemBuilder: (_, index) {
                //               return Container();
                //             });
                //       }
                //     }),
                !isLoading
                    ? GlobalLoading(light: themeChange.darkTheme)
                    : Column(children: [
                        for (int i = 0; i < allDataProducts.length; i++)
                          if (allDataProducts[i]["status"] == "approved")
                            ProductCard(
                              productId: allDataProducts[i]["productId"],
                              brand: allDataProducts[i]["brand"],
                              category: allDataProducts[i]["category"],
                              sellerUid: allDataProducts[i]["uid"],
                              description: allDataProducts[i]["description"],
                              discount: allDataProducts[i]["discount"],
                              img: allDataProducts[i]["productFile"],
                              price: allDataProducts[i]["price"],
                              title: allDataProducts[i]["title"],
                            ),
                      ]),

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
      ),
    );
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    getData();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    getData();
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());
    // if(mounted)
    // setState(() {

    // });
    _refreshController.loadComplete();
  }
}
