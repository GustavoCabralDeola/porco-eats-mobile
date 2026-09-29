class Product {
  final String name;
  final String? description;
  final String brand;
  final String category;
  final double price;
  final String imageUrl;

  Product({
    required this.name,
    required this.description,
    required this.brand,
    required this.category,
    required this.price,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'description': description,
    'brand': brand,
    'category': category,
    'price': price,
    'imageUrl': imageUrl,
  };

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] as String,
      description: json['description'] as String?,
      brand: json['brand'] as String,
      category: json['category'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
    );
  }
}
