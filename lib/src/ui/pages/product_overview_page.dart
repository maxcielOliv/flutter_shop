import 'package:flutter/material.dart';
import 'package:flutter_shop/src/data/models/cart.dart';
import 'package:flutter_shop/src/ui/widgets/app_drawer.dart';
import 'package:flutter_shop/src/ui/widgets/product_grid.dart';
import 'package:flutter_shop/src/util/app_routes.dart';
import 'package:provider/provider.dart';

enum FilterOptions { favorite, all }

class ProductOverviewPage extends StatefulWidget {
  const ProductOverviewPage({super.key});

  @override
  State<ProductOverviewPage> createState() => _ProductOverviewPageState();
}

class _ProductOverviewPageState extends State<ProductOverviewPage> {
  bool showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Minha Loja',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: Theme.of(context).iconTheme,
        actions: [
          PopupMenuButton(
            iconColor: Colors.white,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: FilterOptions.favorite,
                child: Text('Somente Favoritos'),
              ),
              const PopupMenuItem(
                value: FilterOptions.all,
                child: Text('Todos'),
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              setState(
                () {
                  if (selectedValue == FilterOptions.favorite) {
                    showFavoriteOnly = true;
                  } else {
                    showFavoriteOnly = false;
                  }
                },
              );
            },
          ),
          Consumer<Cart>(
            builder: (context, cart, child) => IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.cartPage);
              },
              icon: Badge.count(
                count: cart.itemsCount,
                child: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: ProductGrid(
        showFavoriteOnly: showFavoriteOnly,
      ),
      drawer: const AppDrawer(),
    );
  }
}
