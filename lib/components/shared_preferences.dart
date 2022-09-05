

// save items to shared preference

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';


addStringToSF(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

addIntToSF(String key, int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt(key, value);
}

addDoubleToSF(String key, double value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setDouble('doubleValue', value);
}

addBoolToSF(String key, bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, value);
}
// save to shared preference ends here

// get data from shared preference 

Future<String> getStringValuesSF(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String? stringValue = prefs.getString(key);
  return stringValue.toString();
}
getBoolValuesSF(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return bool
  bool? boolValue = prefs.getBool(key);
  return boolValue;
}
getIntValuesSF(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return int
  int? intValue = prefs.getInt(key);
  return intValue;
}
getDoubleValuesSF(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return double
  double? doubleValue = prefs.getDouble(key);
  return doubleValue;

}

// class CartProvider with ChangeNotifier {
   int _counter = 0;
    List<String> productIdList = [];
void setPrefItems() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    int _counter = 0;
    List<String> productIdList = [];

    _pref.setInt('cart_counter', _counter);
    // _pref.setDouble('totalPrice', _totalPrice);
    _pref.setStringList('cartList',productIdList);
    // notifyListeners();
  }

  Future <int> getPrefItems() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _counter = _pref.getInt("cart_counter") ?? 0;
    // _totalPrice = _pref.getDouble('totalPrice') ?? 0;
    productIdList=_pref.getStringList('cartList')??[];
    return productIdList.length;
    // notifyListeners();
  }
// }





// get data from shared preference ends here