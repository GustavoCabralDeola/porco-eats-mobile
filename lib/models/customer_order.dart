import 'package:porco_eats/models/enums/order_status.dart';
import 'package:porco_eats/models/product.dart';

class CustomerOrder {
  final String id;
  final List<Product> products;
  final double total;
  final OrderStatus status;
  int quantity;
  final String customerName;

  CustomerOrder({
    required this.id,
    required this.products,
    required this.total,
    required this.status,
    this.quantity = 1,
    required this.customerName,
  });

  Product? get firstProduct => products.isNotEmpty ? products.first : null;

  Map<String, dynamic> toJson() => {
    'id': id,
    'products': products.map((product) => product.toJson()).toList(),
    'total': total,
    'status': status.name,
    'quantity': quantity,
    'customerName': customerName,
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
      customerName: json['customerName']?.toString() ?? '',
    );
  }
}
