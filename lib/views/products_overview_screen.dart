import 'package:ShoppingApp/models/product.dart';
import 'package:ShoppingApp/widgets/product_item.dart';
import 'package:flutter/material.dart';
import '../data/dummy_data.dart';

class ProductOverViewScreen extends StatelessWidget {
  final List<Product> _loadedProducts = DUMMY_PRODUCTS;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Minha Loja"),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: _loadedProducts.length,
        itemBuilder: (ctx, index) {
          return ProductItem(_loadedProducts[index]);
        },
      ),
    );
  }
}
