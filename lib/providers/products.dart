import 'dart:convert';
import 'dart:io';

import 'package:ShoppingApp/providers/product.dart';
import 'package:flutter/cupertino.dart';
import '../utils/constants.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  final String _baseUrl = Constants.PRODUCTS_URL;
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Future<void> loadProducts() async {
    final response = await http.get(_baseUrl + ".json");
    Map<String, dynamic> data = json.decode(response.body);

    _items.clear();
    if (data != null) {
      data.forEach((productId, productData) {
        _items.add(new Product(
          id: productId,
          title: productData['title'],
          description: productData['title'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: productData['isFavorite'],
        ));
      });
      notifyListeners();
    }
    return Future.value();
  }

  Future<void> addProduct(Product newProduct) async {
    final response = await http.post(
      _baseUrl + ".json",
      body: json.encode({
        'title': newProduct.title,
        'description': newProduct.description,
        'price': newProduct.price,
        'imageUrl': newProduct.imageUrl,
        'isFavorite': newProduct.isFavorite,
      }),
    );

    _items.add(Product(
      id: json.decode(response.body)['name'],
      title: newProduct.title,
      description: newProduct.title,
      price: newProduct.price,
      imageUrl: newProduct.imageUrl,
    ));
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    if (product == null || product.id == null) return;

    final idc = _items.indexWhere((element) => element.id == product.id);
    if (idc >= 0) {
      await http.patch(
        "$_baseUrl/${product.id}.json",
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
        }),
      );
      _items[idc] = product;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(Product product) async {
    final index = _items.indexWhere((curProduct) => curProduct.id == product.id);
    if (index >= 0) {

      _items.remove(product);
      notifyListeners();
      

      final response = await http.delete("$_baseUrl/${product.id}.json");

      if(response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();
        throw HttpException("Ocorreu um erro na execução do produto!");
      }
    }
  }

  get itemsCount {
    return _items.length;
  }
}
