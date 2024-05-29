import 'package:flutter/material.dart';
import 'package:flutter_kangoolist/authentication/models/mock_user.dart';
import 'package:flutter_kangoolist/authentication/screens/auth_screen.dart';
import 'package:flutter_kangoolist/kangoolists/models/kangoolist.dart';
import 'package:flutter_kangoolist/kangoolists/screens/home_screen.dart';
import 'package:flutter_kangoolist/products/screens/products_screen.dart';

class KangooListRoutes {
  static const String auth = "auth";
  static const String home = "home";
  static const String products = "products";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case auth:
        return MaterialPageRoute(builder: (_) => const AuthScreen());
      case home:
        //TODO: Ao implementar autenticação, substituir usuário mockado.
        return MaterialPageRoute(builder: (_) => HomeScreen(user: MockUser()));
      case products:
        KangooList kangooList = settings.arguments as KangooList;
        return MaterialPageRoute(
            builder: (_) => ProductsScreen(kangooList: kangooList));
      default:
        return MaterialPageRoute(builder: (_) => const AuthScreen());
    }
  }
}
