import 'dart:convert';
import 'dart:io';

import 'package:ShoppingApp/providers/product.dart';
import 'package:flutter/cupertino.dart';
import '../utils/constants.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  final String _baseUrl = Constants.PRODUCTS_URL;
  List<Product> _items = [];
  String _token;
  String _userID;

  Products([this._token, this._items = const [], this._userID]);

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Future<void> loadProducts() async {
    final response = await http.get(_baseUrl + ".json?auth=$_token");
    final isFavResponse = await http.get(
        Constants.BASE_API_URL + "/userFavorites/$_userID.json?auth=$_token");
    final favMap = json.decode(isFavResponse.body);
    Map<String, dynamic> data = json.decode(response.body);

    _items.clear();
    if (data != null) {
      data.forEach((productId, productData) {
        final isFavorite = favMap == null ? false : favMap[productId] ?? false;
        _items.add(new Product(
          id: productId,
          title: productData['title'],
          description: productData['title'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: isFavorite,
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
        "$_baseUrl/${product.id}.json?auth=$_token",
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
    final index =
        _items.indexWhere((curProduct) => curProduct.id == product.id);
    if (index >= 0) {
      _items.remove(product);
      notifyListeners();

      final response =
          await http.delete("$_baseUrl/${product.id}.json?auth=$_token");

      if (response.statusCode >= 400) {
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
