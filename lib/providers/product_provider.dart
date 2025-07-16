import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> loadProducts() async {
    {
      _products = await ApiService.fetchProducts();

      notifyListeners();
    }
  }

  Future<bool> deleteProduct(int id) async {
    final result = await ApiService.deleteProduct(id);
    if (result) {
      _products.removeWhere((p) => p.id == id);
      notifyListeners();
    }
    return result;
  }

  Future<bool> updateProduct(int id, Map<String, dynamic> data) async {
    final result = await ApiService.updateProduct(id, data);
    if (result) {
      final index = _products.indexWhere((p) => p.id == id);
      if (index != -1) {
        final updated = _products[index].copyWith(
          title: data['title'],
          price: data['price'],
        );
        _products[index] = updated;
        notifyListeners();
      }
    }
    return result;
  }

  int _offset = 0;
  final int _limit = 10;

  Future<void> loadProductsPaging() async {
    try {
      _offset = 0;
      final newProducts = await ApiService.fetchProductsPaging(_offset, _limit);
      _products = newProducts;
      notifyListeners();
    } catch (e) {
      print("❌ Error loading paging: $e");
    }
  }

  Future<void> loadMoreProducts() async {
    try {
      _offset += _limit;
      final moreProducts = await ApiService.fetchProductsPaging(
        _offset,
        _limit,
      );
      _products.addAll(moreProducts);
      notifyListeners();
    } catch (e) {
      print("❌ Error loading more: $e");
    }
  }
}
