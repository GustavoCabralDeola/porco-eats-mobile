import 'package:flutter/foundation.dart';
import 'package:porco_eats/models/customer_order.dart';
import 'package:porco_eats/models/enums/order_status.dart';
import 'package:porco_eats/shared/services/app_remember_me.dart';

class OrderListController extends ChangeNotifier {
  OrderListController(this._orderController) {
    searchController.addListener(_notifySearchChanged);
    _orderController.addListener(_syncOrders);
    _syncOrders();
    unawaited(_orderController.loadOrders());
  }

  final CustomerOrderController _orderController;
  final TextEditingController searchController = TextEditingController();
  final List<CustomerOrder> _orders = [];
  OrderStatus? _selectedStatus;
  String? _selectedCustomer;
  String _searchQuery = '';

  OrderStatus? _selectedStatus;
  bool _ongoingOnly = false;
  String? _selectedCustomer;
  bool _isSearching = false;
  bool _isLoading = false;
  String? _errorMessage;

  List<CustomerOrder> get allOrders => List.unmodifiable(_orders);
  OrderStatus? get selectedStatus => _selectedStatus;
  bool get ongoingOnly => _ongoingOnly;
  bool get hasStatusFilter => _selectedStatus != null || _ongoingOnly;
  String get statusFilterLabel =>
      _ongoingOnly ? 'Em andamento' : _selectedStatus?.label ?? 'Status';
  String? get selectedCustomer => _selectedCustomer;
  bool get isSearching => _isSearching;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  bool get hasFilters =>
      hasStatusFilter ||
      _selectedCustomer != null ||
      searchController.text.trim().isNotEmpty;

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
  List<CustomerOrder> get filteredOrders {
    final query = searchController.text.trim().toLowerCase();

    return _orders
        .where((order) {
          final matchesStatus = _ongoingOnly
              ? order.status != OrderStatus.delivered &&
                    order.status != OrderStatus.cancelled
              : _selectedStatus == null || order.status == _selectedStatus;
          final matchesCustomer =
              _selectedCustomer == null ||
              order.customerName == _selectedCustomer;
          final matchesQuery =
              query.isEmpty ||
              order.id.toLowerCase().contains(query) ||
              order.customerName.toLowerCase().contains(query) ||
              order.products.any(
                (product) => product.name.toLowerCase().contains(query),
              );

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
  void setSelectedStatus(OrderStatus? status) {
    _ongoingOnly = false;
    _selectedStatus = status;
    notifyListeners();
  }

  void showOngoingOrders() {
    _selectedStatus = null;
    _ongoingOnly = true;
    _selectedCustomer = null;
    _isSearching = false;
    searchController.clear();
    notifyListeners();
  }

  void showOrdersWithStatus(OrderStatus status) {
    _selectedStatus = status;
    _ongoingOnly = false;
    _selectedCustomer = null;
    _isSearching = false;
    searchController.clear();
    notifyListeners();
  }

  void clearSearch() {
    searchController.clear();
  }

  void clearFilters() {
    _selectedStatus = null;
    _ongoingOnly = false;
    _selectedCustomer = null;
    _searchQuery = '';
    notifyListeners();
  }
}
