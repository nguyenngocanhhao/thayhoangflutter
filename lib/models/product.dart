class Product {
  final int id;
  final String title;
  final int price;
  final String description;
  final String image;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
  });

  // Tạo Product từ JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      image: (json['images'] != null && json['images'].isNotEmpty)
          ? json['images'][0]
          : '',
    );
  }

  // Convert Product về dạng JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'images': [image],
    };
  }

  // Tạo bản sao của Product với dữ liệu mới
  Product copyWith({
    int? id,
    String? title,
    int? price,
    String? description,
    String? image,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      image: image ?? this.image,
    );
  }
}
