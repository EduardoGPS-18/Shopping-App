import 'dart:convert';

import 'package:ShoppingApp/providers/cart.dart';
import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'package:http/http.dart' as http;

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
  String _token;
  String _userID;
  List<Order> get items => [..._items];

  Orders([this._token, this._items, this._userID]);

  int get itemsCount => _items.length;

  Future<void> loadOrders() async {
    List<Order> loadedItems = [];
    final response = await http
        .get(Constants.BASE_API_URL + "/orders/$_userID.json?auth=$_token");
    Map<String, dynamic> data = json.decode(response.body);
    print(data);
    _items.clear();
    if (data != null) {
      data.forEach((orderId, orderData) {
        loadedItems.add(
          new Order(
            id: orderId,
            total: orderData['total'],
            date: DateTime.parse(orderData['date']),
            products: (orderData['products'] as List<dynamic>)
                .map((el) => CartItem(
                      id: el["id"],
                      title: el["title"],
                      quantity: el["quantity"],
                      price: el["price"],
                      productID: el["productId"],
                    ))
                .toList(),
          ),
        );
      });
      notifyListeners();
    }
    _items = loadedItems;
    _items.reversed.toList();
    return Future.value();
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();
    final resp = await http.post(
      Constants.BASE_API_URL + "/orders/$_userID.json?auth=$_token",
      body: json.encode({
        "total": cart.totalAmount,
        "date": date.toIso8601String(),
        "products": cart.item.values
            .map((ci) => {
                  "id": ci.id,
                  "productId": ci.productID,
                  "title": ci.title,
                  "quantity": ci.quantity,
                  "price": ci.price,
                })
            .toList(),
      }),
    );

    _items.insert(
      0,
      Order(
        id: json.decode(resp.body)['name'],
        total: cart.totalAmount,
        date: DateTime.now(),
        products: cart.item.values.toList(),
      ),
    );
    notifyListeners();
  }
}
