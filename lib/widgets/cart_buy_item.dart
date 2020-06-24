import 'package:ShoppingApp/providers/cart.dart';
import 'package:flutter/material.dart';

class CartBuyItem extends StatelessWidget {
  final CartItem cartItem;

  const CartBuyItem(this.cartItem);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: EdgeInsets.all(2),
              child: FittedBox(
                child: Text("R\$ ${cartItem.price}"),
              ),
            ),
          ),
          title: Text(cartItem.title),
          subtitle: Text(
              "Total: R\$ " + (cartItem.price * cartItem.quantity).toString()),
          trailing: Text("${cartItem.quantity}x"),
        ),
      ),
    );
  }
}
