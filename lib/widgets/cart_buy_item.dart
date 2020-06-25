import 'package:ShoppingApp/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartBuyItem extends StatelessWidget {
  final CartItem cartItem;

  const CartBuyItem(this.cartItem);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text("Tem certeza?"),
            content: Text("Quer remover o item do carrinho?"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
                textColor: Theme.of(context).primaryColor,
                child: Text("Sim"),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
                textColor: Theme.of(context).primaryColor,
                child: Text("Não"),
              ),
            ],
          ),
        );
      },
      onDismissed: (_) {
        Provider.of<Cart>(context, listen: false)
            .removeItem(cartItem.productID);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Padding(
                padding: EdgeInsets.all(2),
                child: FittedBox(
                  child: Text("R\$ ${cartItem.price.toStringAsFixed(2)}"),
                ),
              ),
            ),
            title: Text(cartItem.title),
            subtitle: Text("Total: R\$ " +
                (cartItem.price * cartItem.quantity).toString()),
            trailing: Text("${cartItem.quantity}x"),
          ),
        ),
      ),
    );
  }
}
