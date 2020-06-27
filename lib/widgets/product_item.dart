import 'dart:io';

import 'package:ShoppingApp/providers/product.dart';
import 'package:ShoppingApp/providers/products.dart';
import 'package:ShoppingApp/utils/app-routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({this.product});

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.title),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes.PRODUCT_FORM, arguments: product);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text("Excluir Produto!"),
                    content: Text("Tem certeza?"),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(true);
                        },
                        child: Text("Sim"),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(false);
                        },
                        child: Text("Não"),
                      ),
                    ],
                  ),
                ).then((value) async {
                  try {
                    await Provider.of<Products>(context, listen: false).deleteProduct(product);
                  } on HttpException catch(err) {
                    scaffold.showSnackBar(SnackBar(
                      content: Text(err.toString()),
                    ));
                  }
                });
              }
            ),
          ],
        ),
      ),
    );
  }
}
