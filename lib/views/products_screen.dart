import 'package:ShoppingApp/providers/products.dart';
import 'package:ShoppingApp/utils/app-routes.dart';
import 'package:ShoppingApp/widgets/app_drawer.dart';
import 'package:ShoppingApp/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).loadProducts();
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    final productItems = products.items;
    return Scaffold(
      appBar: AppBar(
        title: Text("Gerenciar Produtos"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PRODUCT_FORM);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
          onRefresh: () => _refreshProducts(context),
          child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: products.itemsCount,
            itemBuilder: (ctx, idc) {
              return Column(
                children: <Widget>[
                  ProductItem(product: productItems[idc]),
                  Divider(height: 15),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}