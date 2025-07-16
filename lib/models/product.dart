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
}
