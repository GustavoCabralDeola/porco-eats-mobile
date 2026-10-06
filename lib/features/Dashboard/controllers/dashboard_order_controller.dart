import 'dart:async';

import 'package:flutter/material.dart';
import 'package:porco_eats/features/customer_order/controllers/customer_order_controller.dart';
import 'package:porco_eats/models/customer_order.dart';
import 'package:porco_eats/models/enums/order_status.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';

class DashboardOrderController extends ChangeNotifier {
  DashboardOrderController(CustomerOrderController customerOrderController)
    : _customerOrderController = customerOrderController {
    _customerOrderController.addListener(_syncOrders);
    _syncOrders();
    unawaited(loadOrders());
  }

  final CustomerOrderController _customerOrderController;
  List<CustomerOrder> _orders = [];

  bool isLoading = true;
  String? errorMessage;

  List<CustomerOrder> get orders => List.unmodifiable(_orders);

  List<CustomerOrder> get ongoingOrders => List.unmodifiable(
    _orders.where(
      (order) =>
          order.status != OrderStatus.delivered &&
          order.status != OrderStatus.cancelled,
    ),
  );

  List<CustomerOrder> get recentOrders => List.unmodifiable(
    _orders
        .where(
          (order) =>
              order.status == OrderStatus.delivered ||
              order.status == OrderStatus.cancelled,
        )
        .take(3),
  );

  int countForStatus(OrderStatus status) =>
      _orders.where((order) => order.status == status).length;

  Future<void> loadOrders({bool forceRefresh = true}) =>
      _customerOrderController.loadOrders(forceRefresh: forceRefresh);

  void _syncOrders() {
    _orders = List<CustomerOrder>.of(_customerOrderController.orders);
    isLoading = _customerOrderController.isLoading;
    errorMessage = _customerOrderController.errorMessage;
    notifyListeners();
  }

  Color colorForStatus(OrderStatus status) {
    switch (status) {
      case OrderStatus.received:
        return AppColors.redDelivery;
      case OrderStatus.preparing:
        return AppColors.yellowAgility;
      case OrderStatus.outForDelivery:
        return AppColors.darkBrown;
      case OrderStatus.delivered:
        return const Color(0xFF159447);
      case OrderStatus.cancelled:
        return AppColors.subTitle;
    }
  }

  String formatCurrency(double value) =>
      'R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}';

  String formatItemCount(CustomerOrder order) {
    final quantity = order.quantity;
    return '$quantity ${quantity == 1 ? 'item' : 'itens'}';
  }

  @override
  void dispose() {
    _customerOrderController.removeListener(_syncOrders);
    super.dispose();
  }
}
