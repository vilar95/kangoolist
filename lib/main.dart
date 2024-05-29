import 'package:flutter/material.dart';
import 'package:flutter_kangoolist/_core/kangoolist_routes.dart';
import 'package:flutter_kangoolist/_core/kangoolist_theme.dart';
import 'package:flutter_kangoolist/products/model/product.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KangooList',
      debugShowCheckedModeBanner: false,
      theme: KangooListTheme.mainTheme,
      initialRoute: KangooListRoutes.auth,
      onGenerateRoute: KangooListRoutes.generateRoute,
    );
  }
}
