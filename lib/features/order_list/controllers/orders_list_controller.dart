import 'package:flutter/foundation.dart';
import 'package:porco_eats/models/customer_order.dart';
import 'package:porco_eats/models/enums/order_status.dart';
import 'package:porco_eats/shared/services/app_remember_me.dart';

class OrderListController extends ChangeNotifier {
  final List<CustomerOrder> _orders = [];
  OrderStatus? _selectedStatus;
  String? _selectedCustomer;
  String _searchQuery = '';

  List<CustomerOrder> get allOrders => List.unmodifiable(_orders);
  OrderStatus? get selectedStatus => _selectedStatus;
  String? get selectedCustomer => _selectedCustomer;
  String get searchQuery => _searchQuery;

  List<String> get customers {
    final names = _orders
        .map((order) => order.customerName.trim())
        .where((name) => name.isNotEmpty)
        .toSet()
        .toList()
      ..sort((first, second) => first.compareTo(second));
    return names;
  }

  List<CustomerOrder> get orders {
    final query = _searchQuery.trim().toLowerCase();
    return _orders.where((order) {
      final matchesStatus =
          _selectedStatus == null || order.status == _selectedStatus;
      final matchesCustomer =
          _selectedCustomer == null ||
          order.customerName.trim() == _selectedCustomer;
      final matchesQuery =
          query.isEmpty ||
          order.id.toLowerCase().contains(query) ||
          order.customerName.toLowerCase().contains(query) ||
          order.products.any(
            (product) => product.name.toLowerCase().contains(query),
          );
      return matchesStatus && matchesCustomer && matchesQuery;
    }).toList(growable: false);
  }

  Future<void> loadOrdersFromStorage() async {
    final orders = await AppPreferences().loadOrders();
    _orders
      ..clear()
      ..addAll(orders);
    notifyListeners();
  }

  CustomerOrder? getOrderById(String orderId) {
    for (final order in _orders) {
      if (order.id == orderId) return order;
    }
    return null;
  }

  void removeOrder(String orderId) {
    _orders.removeWhere((order) => order.id == orderId);
    notifyListeners();
  }

  void setStatus(OrderStatus? status) {
    _selectedStatus = status;
    notifyListeners();
  }

  void setCustomer(String? customer) {
    _selectedCustomer = customer;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    if (_searchQuery == query) return;
    _searchQuery = query;
    notifyListeners();
  }

  void clearFilters() {
    _selectedStatus = null;
    _selectedCustomer = null;
    _searchQuery = '';
    notifyListeners();
  }
}
