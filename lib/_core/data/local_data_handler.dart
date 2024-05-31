import 'package:drift/drift.dart';
import 'package:flutter_kangoolist/kangoolists/models/kangoolist.dart';
import 'package:flutter_kangoolist/products/data/products_box_handler.dart';
import 'package:flutter_kangoolist/kangoolists/data/database.dart';

import '../../products/model/product.dart';

class LocalDataHandler {
  Future<Map<String, dynamic>> localDataToMap({
    required AppDatabase appdatabase,
  }) async {
    // Obtém todos os KangooLists salvos
    List<KangooList> listKangooLists = await appdatabase.getKangooLists();

    // Converte de uma lista de KangooLists para uma lista de Map
    List<Map<String, dynamic>> listMappedKangooLists =
        listKangooLists.map((kangooList) => kangooList.toMap()).toList();

    // Para cada KangooList, adicionará uma chave "products" que terá uma lista de produtos
    for (var mappedKangooList in listMappedKangooLists) {
      // Abre a caixa do Hive do KangooList atual
      ProductsBoxHandler pbh = ProductsBoxHandler();
      await pbh.openBox(mappedKangooList["id"]);

      // Obtém todos os produtos do KangooList atual
      List<Product> listProducts = pbh.getProducts();
      List<Map<String, dynamic>> listMappedProducts =
          listProducts.map((product) => product.toMap()).toList();

      // Adiciona nova chave contendo os produtos
      mappedKangooList["products"] = listMappedProducts;

      // Fecha a caixa do Hive
      await pbh.closeBox();
    }

    // Cria o map "pai" que conterá todas as informações
    Map<String, dynamic> finalMap = {};
    finalMap["kangooLists"] = listMappedKangooLists;

    // Devolve o resultado
    return finalMap;
  }

  Future<void> mapToLocalData({
    required Map<String, dynamic> map,
    required AppDatabase appdatabase,
  }) async {
    await appdatabase.kangooListTable.deleteAll();

    for (Map<String, dynamic> mappedKangooList in map["kangooLists"]) {
      // Atualiza o KangooList no Drift
      KangooList kangooList = KangooList.fromMap(mappedKangooList);
      int id = await appdatabase.insertKangooList(kangooList);

      // Abre a caixa do Hive do KangooList atual
      ProductsBoxHandler productsBoxHandler = ProductsBoxHandler();
      await productsBoxHandler.openBox(id.toString());

      // Se houver produtos para adicionar, adiciona.
      if (mappedKangooList["products"] != null) {
        for (Map<String, dynamic> mappedProduct in mappedKangooList["products"]) {
          Product product = Product.fromMap(mappedProduct);
          await productsBoxHandler.addProduct(product);
        }
      }
      // Fecha a caixa do Hive
      await productsBoxHandler.closeBox();
    }
  }
}
