import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descController = TextEditingController();

  bool _isLoading = false;

  Future<void> _submitProduct() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final url = Uri.parse('https://api.escuelajs.co/api/v1/products');
    final body = {
      "title": _titleController.text,
      "price": int.tryParse(_priceController.text) ?? 0,
      "description": _descController.text,
      "categoryId": 25, // bạn có thể cho chọn nếu muốn
      "images": ["https://i.imgur.com/1twoaDy.jpeg"],
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 201) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Thêm sản phẩm thành công')),
        );

        Navigator.pop(context);
        // quay lại màn trước
      } else {
        throw Exception('Lỗi: ${response.body}');
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('❌ Lỗi khi thêm sản phẩm: $e')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm sản phẩm'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Image.network("https://i.imgur.com/1twoaDy.jpeg", height: 100),
              const SizedBox(height: 20),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Tên sản phẩm'),
                validator: (value) =>
                    value!.isEmpty ? 'Vui lòng nhập tên' : null,
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Giá'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Vui lòng nhập giá' : null,
              ),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Mô tả'),
                maxLines: 3,
                validator: (value) =>
                    value!.isEmpty ? 'Vui lòng nhập mô tả' : null,
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: _submitProduct,
                      child: const Text('Thêm sản phẩm'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
