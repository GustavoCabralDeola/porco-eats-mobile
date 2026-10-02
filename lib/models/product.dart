class Product {
  final int id;
  final String name;
  final String? description;
  final String restaurant;
  final double avaliation;
  final String category;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.restaurant,
    required this.avaliation,
    required this.category,
    required this.price,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'avaliation': avaliation,
    'restaurant': restaurant,
    'category': category,
    'price': price,
    'imageUrl': imageUrl,
  };

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] as String,
      description: json['description'] as String?,
      restaurant: json['restaurant'] as String,
      avaliation: (json['avaliation'] as num).toDouble(),
      category: json['category'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
    );
  }
}
