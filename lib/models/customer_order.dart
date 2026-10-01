import 'package:porco_eats/models/enums/order_status.dart';
import 'package:porco_eats/models/product.dart';

class CustomerOrder extends Product {
  final int id;
  final double total;
  final OrderStatus status;
  int quantity;

  CustomerOrder({
    required this.id,
    required this.total,
    required this.status,
    required super.name,
    required super.description,
    required super.restaurant,
    required super.avaliation,
    required super.category,
    required super.price,
    required super.imageUrl,
    this.quantity = 1,
  });
}
