import 'package:ShoppingApp/providers/cart.dart';
import 'package:ShoppingApp/providers/counter_provider.dart';
import 'package:ShoppingApp/utils/app-routes.dart';
import 'package:ShoppingApp/views/cart_screen.dart';
import 'package:ShoppingApp/views/product_detail_screen.dart';
import 'package:ShoppingApp/views/products_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/products.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minha Loja',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        )
      ],
      child: MaterialApp(
        title: "Minha Loja",
        theme: ThemeData(
          primaryColor: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ProductOverViewScreen(),
        routes: {
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailScreen(),
          AppRoutes.CART: (ctx) => CartScreen(),
        },
      ),
    );
  }
}
