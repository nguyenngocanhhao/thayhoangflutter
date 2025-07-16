import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static const String baseUrl = 'https://api.escuelajs.co/api/v1/products';

  static Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  static Future<bool> deleteProduct(int id) async {
    final url = Uri.parse('https://api.escuelajs.co/api/v1/products/$id');
    {
      final response = await http.delete(url);
      return response.statusCode == 200;
    }
  }

  static Future<bool> updateProduct(int id, Map<String, dynamic> data) async {
    final url = Uri.parse('https://api.escuelajs.co/api/v1/products/$id');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );
      return response.statusCode == 200;
    } catch (e) {
      print('❌ Lỗi khi cập nhật sản phẩm: $e');
      return false;
    }
  }

  static Future<List<Product>> fetchProductsPaging(
    int offset,
    int limit,
  ) async {
    final url = Uri.parse(
      'https://api.escuelajs.co/api/v1/products?offset=$offset&limit=$limit',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products with paging');
    }
  }
}
