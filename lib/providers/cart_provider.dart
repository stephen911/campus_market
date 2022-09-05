// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';

// class CartProvider with ChangeNotifier {
//   int? _counter ;

//   Box counterTheme = Hive.box("CartCounter");

//   int? counter() {
//     _counter = counterTheme.get('counter');
    
//     // _getPrefItems();
//     return _counter;
//   }
// }
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  int _counter = 0;
  double _totalPrice = 0;
  List<String> _cartList=[];


  int counter() {
    _getPrefItems();
    return _counter;
  }

  double totalPrice() {
    _getPrefItems();
    return _totalPrice;
  }

  List<String> cartList(){
    _getPrefItems();
    return _cartList;
  }



  void addToTotalPrice(double productPrice) {
    _totalPrice += productPrice;
    _setPrefItems();
    notifyListeners();
  }

  void removeFromTotalPrice(double productPrice) {
    _totalPrice -= productPrice;
    _setPrefItems();
    notifyListeners();
  }

  void _setPrefItems() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setInt('cart_counter', _counter);
    _pref.setDouble('totalPrice', _totalPrice);
    _pref.setStringList('cartList',_cartList);
    notifyListeners();
  }

  void _getPrefItems() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _counter = _pref.getInt("cart_counter") ?? 0;
    _totalPrice = _pref.getDouble('totalPrice') ?? 0;
    _cartList=_pref.getStringList('cartList')??[];
    notifyListeners();
  }

  void increment() {
    _counter++;
    _setPrefItems();
    notifyListeners();
  }

  void decrement() {
    _counter--;
    _setPrefItems();
    notifyListeners();
  }

  void addtoList(String item){
    _cartList.add(item);
    _setPrefItems();
     notifyListeners();
  }

    void removefromList(String item){
    _cartList.remove(item);
    _setPrefItems();
     notifyListeners();
  }

  bool isInCart(String item){
    _getPrefItems();
    return _cartList.contains(item);
  }

}
