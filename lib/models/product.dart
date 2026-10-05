class Product {
  final int id;
  final String name;
  final String? description;
  final String restaurant;
  final double avaliation;
  final String category;
  final double price;
  final String imageUrl;
  String? observation;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.restaurant,
    required this.avaliation,
    required this.category,
    required this.price,
    required this.imageUrl,
    this.observation,
  });

  Product copyWith({
    int? id,
    String? name,
    String? description,
    String? restaurant,
    double? avaliation,
    String? category,
    double? price,
    String? imageUrl,
    String? observation,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      restaurant: restaurant ?? this.restaurant,
      avaliation: avaliation ?? this.avaliation,
      category: category ?? this.category,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      observation: observation ?? this.observation,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'avaliation': avaliation,
    'restaurant': restaurant,
    'category': category,
    'price': price,
    'imageUrl': imageUrl,
    'observation': observation,
  };

  factory Product.fromJson(Map<String, dynamic> json) {
    final restaurant = json['restaurant'] ?? json['brand'];

    return Product(
      id: json['id'] ?? 0,
      name: json['name'] as String,
      description: json['description'] as String?,
      restaurant: restaurant as String,
      avaliation: (json['avaliation'] as num).toDouble(),
      category: json['category'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      observation: json['observation'] as String?,
    );
  }
}
