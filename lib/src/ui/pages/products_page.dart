import 'package:flutter/material.dart';
import 'package:flutter_shop/src/data/providers/product_list.dart';
import 'package:flutter_shop/src/ui/pages/product_item.dart';
import 'package:flutter_shop/src/ui/widgets/app_drawer.dart';
import 'package:flutter_shop/src/util/app_routes.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Produtos'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.productFormPage);
              products.getProduct();
            },
            icon: const Icon(Icons.add),
          )
        ],
        backgroundColor: Theme.of(context).primaryColor,
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: products.itemsCount,
          itemBuilder: (context, index) => Column(
            children: [
              ProductItem(
                product: products.items[index],
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
