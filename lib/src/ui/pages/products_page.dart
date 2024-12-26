import 'package:flutter/material.dart';
import 'package:flutter_shop/src/data/providers/product_list.dart';
import 'package:flutter_shop/src/ui/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);
    return Scaffold(
      appBar: AppBar(),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: products.itemsCount,
          itemBuilder: (context, index) => Text(products.items[index].name),
        ),
      ),
    );
  }
}
