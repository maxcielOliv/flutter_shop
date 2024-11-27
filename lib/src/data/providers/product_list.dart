import 'package:flutter/material.dart';
import 'package:flutter_shop/src/data/dummy_data.dart';
import 'package:flutter_shop/src/data/models/product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  void addProduct(Product product) {
    items.add(product);
    notifyListeners();
  }
}
