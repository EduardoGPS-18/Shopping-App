import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    @required this.price,
    this.isFavorite = false,
  });

  void _toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toggleFavorite() async {
    _toggleFavorite();

    try {
      final response = await http.patch(
        Constants.PRODUCTS_URL + "/$id.json",
        body: json.encode({
          'isFavorite': isFavorite,
        }),
      );

      if(response.statusCode >= 400) {
        _toggleFavorite();
      }
    } catch(err) {
      _toggleFavorite();
    }
  }
}
