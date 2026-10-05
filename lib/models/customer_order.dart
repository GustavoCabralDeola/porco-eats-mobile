import 'package:porco_eats/models/enums/order_status.dart';
import 'package:porco_eats/models/product.dart';

class CustomerOrder {
  final String id;
  final List<Product> products;
  final double total;
  final OrderStatus status;
  int quantity;
  final String customerName;
  final String? customerEmail;
  final DateTime? createdAt;

  CustomerOrder({
    required this.id,
    required this.products,
    required this.total,
    required this.status,
    this.quantity = 1,
    required this.customerName,
    this.customerEmail,
    this.createdAt,
  });

  Product? get firstProduct => products.isNotEmpty ? products.first : null;

  Map<String, dynamic> toJson() => {
    'id': id,
    'products': products.map((product) => product.toJson()).toList(),
    'total': total,
    'status': status.name,
    'quantity': quantity,
    'customerName': customerName,
    'customerEmail': customerEmail,
    'createdAt': createdAt?.toIso8601String(),
  };

  factory CustomerOrder.fromJson(Map<String, dynamic> json) {
    return CustomerOrder(
      id: json['id']?.toString() ?? '',
      products: (json['products'] as List? ?? [])
          .map((item) => Product.fromJson(item as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      status: OrderStatus.values.firstWhere(
        (value) => value.name == json['status'],
        orElse: () => OrderStatus.received,
      ),
      quantity: json['quantity'] as int? ?? 1,
      customerName: _customerNameFromJson(json),
      customerEmail: json['customerEmail'] as String?,
      createdAt: DateTime.tryParse(json['createdAt'] as String? ?? ''),
    );
  }

  static String _customerNameFromJson(Map<String, dynamic> json) {
    final name = json['customerName'] ?? json['customer_name'] ?? json['name'];
    if (name is String && name.trim().isNotEmpty) {
      return name.trim();
    }

    final customer = json['customer'];
    if (customer is String && customer.trim().isNotEmpty) {
      return customer.trim();
    }
    if (customer is Map && customer['name'] is String) {
      return (customer['name'] as String).trim();
    }

    return '';
  }
}
