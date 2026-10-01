import 'package:flutter/foundation.dart';
import 'package:porco_eats/features/order_list/controllers/customer_order.dart';
import 'package:porco_eats/features/order_list/controllers/order_list_card.dart';


class OrderListController extends ChangeNotifier {
  final List<CustomerOrder> _orders = [];

  List<CustomerOrder> get allOrders => List.unmodifiable(_orders);

  String? _selectedStatus;

  String? get selectedStatus => _selectedStatus;

  List<CustomerOrder> get orders {
    List<CustomerOrder> result = List.from(_orders);

    if (_selectedStatus != null) {
      result = result.where((order) {
        return order.status.toString() == _selectedStatus;
      }).toList();
    }

    return result;
  }

  void addOrder(CustomerOrder order) {
    _orders.add(order);
    notifyListeners();
  }

  CustomerOrder? getOrderById(int orderId) {
    try {
      return _orders.firstWhere(
        (order) => order.id == orderId,
      );
    } catch (_) {
      return null;
    }
  }

  void removeOrder(int orderId) {
    _orders.removeWhere(
      (order) => order.id == orderId,
    );

    notifyListeners();
  }

  void setStatus(String? status) {
    _selectedStatus = status;
    notifyListeners();
  }

  void clearFilters() {
    _selectedStatus = null;
    notifyListeners();
  }
}