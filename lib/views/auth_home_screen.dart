import 'package:ShoppingApp/providers/auth.dart';
import 'package:ShoppingApp/views/auth_screen.dart';
import 'package:ShoppingApp/views/products_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthOrHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context, listen: true);
    return FutureBuilder(
      future: auth.tryAutoLogin(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.error != null) {
          return Center(child: Text("Ocorreu um erro!"));
        } else {
          return auth.isAuth ? ProductOverViewScreen() : AuthScreen();
        }
      },
    );
  }
}
