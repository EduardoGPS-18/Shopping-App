import 'dart:math';

import 'package:ShoppingApp/providers/product.dart';
import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String productID;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.productID,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get item {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0;
    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void addCartItem(Product item) {
    if (_items.containsKey(item.id)) {
      _items.update(
        item.id,
        (existingItem) => CartItem(
          productID: item.id,
          id: existingItem.id,
          price: existingItem.price,
          quantity: existingItem.quantity + 1,
          title: existingItem.title,
        ),
      );
    } else {
      _items.putIfAbsent(
        item.id,
        () => CartItem(
          id: Random().nextDouble().toString(),
          productID: item.id,
          title: item.title,
          quantity: 1,
          price: item.price,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productID) {
    _items.removeWhere((key, value) => value.productID == productID);
    notifyListeners();
  }
}
