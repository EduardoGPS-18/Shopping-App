import 'package:ShoppingApp/providers/orders.dart';
import 'package:ShoppingApp/widgets/app_drawer.dart';
import 'package:ShoppingApp/widgets/order_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Orders orders = Provider.of<Orders>(context); 
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Pedidos")
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orders.itemsCount,
        itemBuilder: (ctx, index) {
          return OrderWidget(orders.items[index]);
        },
      ),
    );
  }
}