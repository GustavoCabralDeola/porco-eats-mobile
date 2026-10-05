import 'dart:async';

import 'package:flutter/material.dart';
import 'package:porco_eats/features/customer_order/controllers/customer_order_controller.dart';
import 'package:porco_eats/models/customer_order.dart';
import 'package:porco_eats/models/enums/order_status.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';

class DashboardOrderController extends ChangeNotifier {
  DashboardOrderController(this._orderController) {
    _orderController.addListener(_syncOrders);
    unawaited(_orderController.loadOrders());
  }

  final CustomerOrderController _orderController;

  bool get isLoading => _orderController.isLoading;
  String? get errorMessage => _orderController.errorMessage;

  List<CustomerOrder> get orders => _orderController.orders;

  List<CustomerOrder> get ongoingOrders => List.unmodifiable(
    orders.where(
      (order) =>
          order.status != OrderStatus.delivered &&
          order.status != OrderStatus.cancelled,
    ),
  );

  List<CustomerOrder> get recentOrders => List.unmodifiable(
    orders.where((order) => order.status == OrderStatus.delivered),
  );

  int countForStatus(OrderStatus status) =>
      orders.where((order) => order.status == status).length;

  Future<void> loadOrders() =>
      _orderController.loadOrders(forceRefresh: true);

  void _syncOrders() => notifyListeners();

  @override
  void dispose() {
    _orderController.removeListener(_syncOrders);
    super.dispose();
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
}
