import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CartProvider with ChangeNotifier {
  int? _counter ;

  Box counterTheme = Hive.box("CartCounter");

  int? counter() {
    _counter = counterTheme.get('counter');
    
    // _getPrefItems();
    return _counter;
  }
}
