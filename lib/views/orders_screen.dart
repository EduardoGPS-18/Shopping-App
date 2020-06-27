import 'package:ShoppingApp/providers/orders.dart';
import 'package:ShoppingApp/widgets/app_drawer.dart';
import 'package:ShoppingApp/widgets/order_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Meus Pedidos")),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).loadOrders(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if(snapshot.error != null) {
            return Center(child: Text("Ocorreu um erro inesperado!"));
          } else {
            return Consumer<Orders> (
              builder: (ctx, orders, child) => ListView.builder(
                itemCount: orders.itemsCount,
                itemBuilder: (ctx, index) {
                  return OrderWidget(orders.items[index]);
                }
              )
            );
          }
        },
      ),
    );
  }
}
