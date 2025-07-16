import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> loadProducts() async {
    try {
      _products = await ApiService.fetchProducts();
      print("✅ Loaded ${_products.length} products");
      notifyListeners();
    } catch (e) {
      print("❌ Error loading products: $e");
    }
  }
}
