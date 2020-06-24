import 'package:ShoppingApp/providers/product.dart';
import 'package:ShoppingApp/providers/products.dart';
import 'package:ShoppingApp/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {

  final bool _showFavoriteOnly;

  ProductGrid(this._showFavoriteOnly);

  @override
  Widget build(BuildContext context) {
    final loadedProducts = Provider.of <Products>(context);
    final products = !_showFavoriteOnly ? loadedProducts.items : loadedProducts.favoriteItems;
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: products.length,
      itemBuilder: (ctx, index) {
        return ChangeNotifierProvider.value(
          value: products[index],
          child: ProductItem(),
        );
      },
    );
  }
}
