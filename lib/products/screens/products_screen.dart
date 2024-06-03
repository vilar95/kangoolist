import 'package:flutter/material.dart';
import 'package:flutter_kangoolist/products/data/products_box_handler.dart';
import 'package:flutter_kangoolist/products/helpers/enum_order.dart';
import 'package:flutter_kangoolist/products/screens/widgets/product_add_edit_modal.dart';
import '../../kangoolists/models/kangoolist.dart';
import '../model/product.dart';
import 'widgets/product_list_item.dart';

class ProductsScreen extends StatefulWidget {
  final KangooList kangooList;
  const ProductsScreen({super.key, required this.kangooList});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Product> listaProdutosPlanejados = [];
  List<Product> listaProdutosPegos = [];

  OrdemProduto ordem = OrdemProduto.name;
  bool isDecrescente = false;

  bool isPlanejadosExpanded = true;
  bool isPegosExpanded = true;

  bool isGroupedByCategory = false;

  final ProductsBoxHandler _productsBoxHandler = ProductsBoxHandler();
  @override
  void initState() {
    _productsBoxHandler
        .openBox(widget.kangooList.id)
        .then((value) => refresh());

    super.initState();
  }

  @override
  void dispose() {
    _productsBoxHandler.closeBox();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.kangooList.name),
        centerTitle: false,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: OrdemProduto.name,
                  child: Text("Ordenar por nome"),
                ),
                const PopupMenuItem(
                  value: OrdemProduto.amount,
                  child: Text("Ordenar por quantidade"),
                ),
                const PopupMenuItem(
                  value: OrdemProduto.price,
                  child: Text("Ordenar por preço"),
                ),
              ];
            },
            onSelected: (value) {
              setState(() {
                if (ordem == value) {
                  isDecrescente = !isDecrescente;
                } else {
                  ordem = value;
                  isDecrescente = false;
                }
              });
              refresh();
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddEditModal();
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return refresh();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 48, bottom: 32),
                child: Column(
                  children: [
                    Text(
                      "R\$${_calculateTotalPrice().toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 52),
                    ),
                    const Text(
                      "total previsto para essa compra",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              ExpansionPanelList(
                expandedHeaderPadding: const EdgeInsets.all(8),
                expansionCallback: (panelIndex, isExpanded) {
                  setState(() {
                    isPlanejadosExpanded = !isPlanejadosExpanded;
                  });
                },
                children: [
                  ExpansionPanel(
                    isExpanded: isPlanejadosExpanded,
                    canTapOnHeader: true,
                    backgroundColor: Colors.white,
                    headerBuilder: (context, isExpanded) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ListTile(
                          leading: const Icon(Icons.format_list_bulleted),
                          title: Text(
                            "Planejados (${listaProdutosPlanejados.length})",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: const Text(
                              "Produtos planejados para esta compra"),
                        ),
                      );
                    },
                    body: Column(
                      children: List.generate(listaProdutosPlanejados.length,
                          (index) {
                        Product produto = listaProdutosPlanejados[index];
                        return ProductListItem(
                          kangooListId: widget.kangooList.id,
                          produto: produto,
                          isComprado: false,
                          showModal: showAddEditModal,
                          iconClick: _toggleProductStatus,
                          trailClick: _removeProduct,
                        );
                      }),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                // child: Divider(),
              ),
              ExpansionPanelList(
                expandedHeaderPadding: const EdgeInsets.all(8),
                expansionCallback: (panelIndex, isExpanded) {
                  setState(() {
                    isPegosExpanded = !isPegosExpanded;
                  });
                },
                children: [
                  ExpansionPanel(
                    isExpanded: isPegosExpanded,
                    canTapOnHeader: true,
                    backgroundColor: Colors.white,
                    headerBuilder: (context, isExpanded) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ListTile(
                          leading: const Icon(Icons.shopping_cart_outlined),
                          title: Text(
                            "No carrinho (${listaProdutosPegos.length}) ",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: const Text(
                              "Produtos que já foram postos no carrinho"),
                        ),
                      );
                    },
                    body: Column(
                      children:
                          List.generate(listaProdutosPegos.length, (index) {
                        Product produto = listaProdutosPegos[index];
                        return ProductListItem(
                          kangooListId: widget.kangooList.id,
                          produto: produto,
                          isComprado: true,
                          showModal: showAddEditModal,
                          iconClick: _toggleProductStatus,
                          trailClick: _removeProduct,
                        );
                      }),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 64),
            ],
          ),
        ),
      ),
    );
  }

  refresh() async {
    List<Product> listProducts = _productsBoxHandler.getProducts();

    _filterProducts(listProducts);
  }

  _removeProduct(Product produto) async {
    _productsBoxHandler.removeProduct(produto);
    refresh();
  }

  showAddEditModal({Product? product}) {
    showProductAddEditProductModal(
      context: context,
      onRefresh: refresh,
      product: product,
      productBoxHandler: _productsBoxHandler,
    );
  }

  _toggleProductStatus(
      {required Product produto, required String kangooListId}) {
    produto.isPurchased = !produto.isPurchased;
    _productsBoxHandler.updateProduct(produto);
    refresh();
  }

  _filterProducts(List<Product> listaProdutos) {
    List<Product> tempPlanejados = [];
    List<Product> tempPegos = [];

    for (var produto in listaProdutos) {
      if (produto.isPurchased) {
        tempPegos.add(produto);
      } else {
        tempPlanejados.add(produto);
      }
    }

    setState(() {
      listaProdutosPegos = tempPegos;
      listaProdutosPlanejados = tempPlanejados;
    });
  }

  double _calculateTotalPrice() {
    double total = 0;
    for (Product produto in listaProdutosPegos) {
      if (produto.amount != null && produto.price != null) {
        total += (produto.amount! * produto.price!);
      }
    }
    return total;
  }
}
