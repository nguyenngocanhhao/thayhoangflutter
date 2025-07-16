import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<void> _loadFuture;

  @override
  void initState() {
    super.initState();
    _loadFuture = Provider.of<ProductProvider>(
      context,
      listen: false,
    ).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Danh sách sản phẩm'),
        backgroundColor: Colors.amber[700],
        foregroundColor: Colors.black,
      ),
      body: FutureBuilder(
        future: _loadFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.amber),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                '❌ Lỗi khi tải: ${snapshot.error}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          return ListView.builder(
            itemCount: provider.products.length,
            padding: const EdgeInsets.all(12),
            itemBuilder: (context, index) {
              final product = provider.products[index];
              return Card(
                color: Colors.grey[900],
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  leading: Image.network(
                    product.image,
                    width: 50,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.image, color: Colors.white),
                  ),
                  title: Text(
                    product.title,
                    style: const TextStyle(color: Colors.amber),
                  ),
                  subtitle: Text(
                    '${product.price} đ',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
