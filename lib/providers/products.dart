import 'dart:math';

import 'package:ShoppingApp/data/dummy_data.dart';
import 'package:ShoppingApp/providers/product.dart';
import 'package:flutter/cupertino.dart';

class Products with ChangeNotifier {

  List<Product> _items = DUMMY_PRODUCTS;

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  void addProduct(Product newProduct) {
    _items.add(Product(
      id: Random().nextDouble().toString(),
      title: newProduct.title,
      description: newProduct.title,
      price: newProduct.price,
      imageUrl: newProduct.imageUrl,
    ));
    notifyListeners();
  }

  void updateProduct(Product product) {
    if(product == null || product.id == null) return;

    final idc = _items.indexWhere((element) => element.id == product.id);
    if(idc >= 0) {
      _items[idc] = product;
      notifyListeners();
    }
  }

  void deleteProduct(Product product) {
    final index = _items.indexWhere((curProduct) => curProduct.id == product.id);
    if(index >= 0) {
      _items.removeWhere((element) => element.id == product.id);
      notifyListeners();
    }
  }

  get itemsCount {
    return _items.length;
  }
}