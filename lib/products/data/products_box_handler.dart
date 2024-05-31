import 'package:flutter_kangoolist/products/model/product.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProductsBoxHandler {
  late Box _box;

  Future<void> openBox(String kangooId) async {
    _box = await Hive.openBox(kangooId);
  }

  Future<void> closeBox() async {
    await _box.close();
  }

  Future<int> addProduct(Product product) async {
    return _box.add(product);
  }

  List<Product> getProducts() {
    return _box.values.map((elemento) => elemento as Product).toList();
  }

  Future<void> updateProduct(Product product) async {
    return product.save();
  }
  Future<void> removeProduct(Product product) async {
    return _box.delete(product.key);
  }
}
