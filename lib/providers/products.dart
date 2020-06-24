import 'package:ShoppingApp/data/dummy_data.dart';
import 'package:ShoppingApp/providers/product.dart';
import 'package:flutter/cupertino.dart';

class Products with ChangeNotifier {

  List<Product> _items = DUMMY_PRODUCTS;

  // bool _showFavoriteOnly = false;

  List<Product> get items {
    // if(_showFavoriteOnly) {
    //   return items.where((element) => element.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  void addProduct(Product product) {
    items.add(product);
    notifyListeners();
  }

  // void showFavoriteOnly() {
  //   _showFavoriteOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoriteOnly = false;
  //   notifyListeners();
  // }
}