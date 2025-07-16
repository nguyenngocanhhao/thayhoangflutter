import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thayhoangflutter/screens/edit_product_screen.dart';
import '../providers/product_provider.dart';
import '../screens/add_product_screen.dart';
import '../screens/product_detail_screen.dart';

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
    ).loadProductsPaging();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 235, 229),
      appBar: AppBar(
        title: const Text('Danh sách sản phẩm'),
        backgroundColor: Colors.amber[700],
        foregroundColor: const Color.fromARGB(255, 78, 40, 25),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        foregroundColor: const Color.fromARGB(255, 78, 40, 25),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddProductScreen()),
          );
        },
        child: const Icon(Icons.add),
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
            itemCount: provider.products.length + 1, // +1 cho nút "Xem thêm"
            padding: const EdgeInsets.all(12),
            itemBuilder: (context, index) {
              if (index < provider.products.length) {
                final product = provider.products[index];

                return Card(
                  color: const Color.fromARGB(255, 241, 123, 0),
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
                      style: const TextStyle(
                        color: Color.fromARGB(255, 78, 40, 25),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${product.price} USD',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    EditProductScreen(product: product),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.white),
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text("Xoá sản phẩm"),
                                content: Text(
                                  "Bạn có chắc muốn xoá '${product.title}'?",
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text("Không"),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: const Text("Xoá"),
                                  ),
                                ],
                              ),
                            );

                            if (confirm != true) return;

                            final result = await provider.deleteProduct(
                              product.id,
                            );

                            if (!context.mounted) return;

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  result
                                      ? '✅ Đã xoá thành công'
                                      : '❌ Xoá thất bại',
                                ),
                                backgroundColor: result
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            );

                            setState(() {
                              _loadFuture = provider.loadProducts();
                            });
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailScreen(product: product),
                        ),
                      );
                    },
                  ),
                );
              } else {
                // Widget nút "Xem thêm"
                return Center(
                  child: TextButton.icon(
                    onPressed: () async {
                      await provider
                          .loadMoreProducts(); // Hàm bạn cần định nghĩa trong ProductProvider
                    },
                    icon: const Icon(Icons.expand_more),
                    label: const Text(
                      'Xem thêm',
                      style: TextStyle(
                        fontSize: 16, // tăng kích thước chữ
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 78, 40, 25), // in đậm
                      ),
                    ),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
