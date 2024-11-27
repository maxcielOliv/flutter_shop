import 'package:flutter/material.dart';
import 'package:flutter_shop/src/data/models/order_list.dart';
import 'package:flutter_shop/src/ui/widgets/app_drawer.dart';
import 'package:flutter_shop/src/ui/widgets/order_widget.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Meus Pedidos',
        ),
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orders.items.length,
        itemBuilder: (context, index) =>
            OrderWidget(order: orders.items[index]),
      ),
    );
  }
}
