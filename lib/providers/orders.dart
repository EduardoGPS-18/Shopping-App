import 'dart:math';

import 'package:ShoppingApp/providers/cart.dart';
import 'package:flutter/material.dart';

class Order {
  final String id;
  final double total;
  final List<CartItem> products;
  final DateTime date;

  Order({
    this.id,
    this.total,
    this.products,
    this.date,
  });
}

class Orders with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items => [..._items];

  int get itemsCount => _items.length;

  void addOrder(Cart cart) {
    // final combine = (total, item) => total + (item.price * item.quantity);
    // products.fold(0, combine);
    _items.insert(
      0,
      Order(
        id: Random().nextDouble().toString() + Random().nextDouble().toString(),
        total: cart.totalAmount,
        date: DateTime.now(),
        products: cart.item.values.toList(),
      ),
    );
    notifyListeners();
  }
}
