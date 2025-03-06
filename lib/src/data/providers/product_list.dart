import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_shop/src/data/dummy_data.dart';
import 'package:flutter_shop/src/data/models/product.dart';
import 'package:http/http.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;
  final _baseUrl = 'https://flutter-shop-5575a-default-rtdb.firebaseio.com/';

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      _items.where((prod) => prod.isFavorite).toList();

  int get itemsCount {
    return _items.length;
  }

  Future<void> saveProduct(Map<String, Object> data) {
    final hasId = data['id'] != null;

    final product = Product(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );
    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> addProduct(Product product) {
    return post(
      Uri.parse('$_baseUrl/product.json'),
      body: jsonEncode(
        {
          "name": product.name,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
          "isFavorite": product.isFavorite,
        },
      ),
    ).then<void>(
      (response) {
        final id = jsonDecode(response.body)['name'];
        _items.add(
          Product(
            id: id,
            name: product.name,
            description: product.description,
            price: product.price,
            imageUrl: product.imageUrl,
            isFavorite: product.isFavorite,
          ),
        );
        notifyListeners();
      },
    );
  }

  Future<void> updateProduct(Product product) {
    int index = items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }

    return Future.value();
  }

  void deleteProduct(Product product) {
    int index = items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
  }
}
