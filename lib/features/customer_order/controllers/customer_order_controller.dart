import 'dart:async';

import 'package:flutter/material.dart';
import 'package:porco_eats/models/customer_order.dart';
import 'package:porco_eats/models/enums/order_status.dart';
import 'package:porco_eats/models/user.dart';
import 'package:porco_eats/shared/services/app_remember_me.dart';

class CustomerOrderController extends ChangeNotifier {
  CustomerOrderController({AppPreferences? preferences})
    : _preferences = preferences ?? AppPreferences() {
    unawaited(loadOrders());
  }

  final AppPreferences _preferences;
  final List<CustomerOrder> _orders = [];
  bool _isLoading = false;
  bool _hasLoaded = false;
  String? _errorMessage;
  Future<List<CustomerOrder>>? _loadFuture;

  List<CustomerOrder> get orders => List.unmodifiable(_orders);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  List<CustomerOrder> ordersForCustomer(User? user) {
    if (user == null) return const [];

    final email = user.email.trim().toLowerCase();
    final name = user.name.trim().toLowerCase();
    return _orders
        .where((order) {
          final orderEmail = order.customerEmail?.trim().toLowerCase();
          if (orderEmail != null && orderEmail.isNotEmpty) {
            return orderEmail == email;
          }
          return order.customerName.trim().toLowerCase() == name;
        })
        .toList(growable: false);
  }

  int activeOrderCountFor(User? user) => ordersForCustomer(user)
      .where(
        (order) =>
            order.status != OrderStatus.delivered &&
            order.status != OrderStatus.cancelled,
      )
      .length;

  Future<void> loadOrders({bool forceRefresh = false}) async {
    if (_hasLoaded && !forceRefresh) return;

    final activeLoad = _loadFuture;
    if (activeLoad != null) {
      await activeLoad;
      if (!forceRefresh) return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    final loadFuture = _preferences.loadOrders();
    _loadFuture = loadFuture;
    try {
      final orders = await loadFuture;
      _orders
        ..clear()
        ..addAll(orders);
      _hasLoaded = true;
    } catch (error) {
      _errorMessage = 'Não foi possível carregar os pedidos: $error';
    } finally {
      _isLoading = false;
      _loadFuture = null;
      notifyListeners();
    }
  }

  Future<void> addOrder(CustomerOrder order) async {
    await loadOrders();
    if (_errorMessage != null) throw StateError(_errorMessage!);

    final updatedOrders = <CustomerOrder>[order, ..._orders];
    await _preferences.saveOrders(updatedOrders);
    _orders
      ..clear()
      ..addAll(updatedOrders);
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> updateOrderStatus(String orderId, OrderStatus status) async {
    await loadOrders();
    if (_errorMessage != null) throw StateError(_errorMessage!);

    final index = _orders.indexWhere((order) => order.id == orderId);
    if (index == -1) {
      throw StateError('Pedido $orderId não foi encontrado.');
    }

    final currentOrder = _orders[index];
    if (currentOrder.status == status) return;

    final updatedOrders = List<CustomerOrder>.of(_orders)
      ..[index] = CustomerOrder(
        id: currentOrder.id,
        products: currentOrder.products,
        total: currentOrder.total,
        status: status,
        quantity: currentOrder.quantity,
        customerName: currentOrder.customerName,
        customerEmail: currentOrder.customerEmail,
        createdAt: currentOrder.createdAt,
      );

    await _preferences.saveOrders(updatedOrders);
    _orders
      ..clear()
      ..addAll(updatedOrders);
    notifyListeners();
  }
}