import 'package:flutter/material.dart';
import 'package:flutter_shop/src/data/models/cart.dart';
import 'package:flutter_shop/src/data/models/order_list.dart';
import 'package:flutter_shop/src/data/providers/product_list.dart';
import 'package:flutter_shop/src/ui/pages/cart_page.dart';
import 'package:flutter_shop/src/ui/pages/orders_page.dart';
import 'package:flutter_shop/src/ui/pages/product_detail_page.dart';
import 'package:flutter_shop/src/ui/pages/product_overview_page.dart';
import 'package:flutter_shop/src/util/app_routes.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductList(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderList(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.pink,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepOrange,
              primary: Colors.deepOrange,
            ),
            fontFamily: 'Lato',
            useMaterial3: true,
            textTheme: const TextTheme(
              titleMedium: TextStyle(color: Colors.white),
            ),
            appBarTheme: AppBarTheme(color: Colors.white)),
        routes: {
          AppRoutes.home: (context) => const ProductOverviewPage(),
          AppRoutes.productDetail: (context) => const ProductDetailPage(),
          AppRoutes.cartPage: (context) => const CartPage(),
          AppRoutes.ordersPage: (context) => const OrdersPage(),
        },
      ),
    );
  }
}
