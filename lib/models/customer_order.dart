import 'package:porco_eats/models/enums/order_status.dart';

class CustomerOrder {
  final int id;
  final double total;
  final OrderStatus status;

  CustomerOrder({required this.id, required this.total, required this.status});
}
