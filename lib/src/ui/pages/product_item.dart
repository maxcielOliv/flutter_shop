import 'package:flutter/material.dart';
import 'package:flutter_shop/src/data/models/product.dart';
import 'package:flutter_shop/src/data/providers/product_list.dart';
import 'package:flutter_shop/src/util/app_routes.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.name),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.productFormPage,
                  arguments: product,
                );
              },
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).primaryColor,
              ),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Exclusão'),
                    content: const Text('Deseja Excluir esse item?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Provider.of<ProductList>(
                            context,
                            listen: false,
                          ).deleteProduct(product);
                          Navigator.of(context).pop();
                        },
                        child: const Text('Sim'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Não'),
                      ),
                    ],
                  ),
                );
              },
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
