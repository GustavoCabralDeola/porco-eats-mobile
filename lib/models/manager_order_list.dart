class ManagerOrderList {
  final int id;
  final String customerName;
  final double total;
  final OrderStatus status;

  ManagerOrderList({
    required this.id,
    required this.customerName,
    required this.total,
    required this.status,
  });
}
