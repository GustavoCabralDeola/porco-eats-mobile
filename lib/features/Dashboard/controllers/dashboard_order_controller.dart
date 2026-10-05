import 'package:flutter/material.dart';
import 'package:porco_eats/models/customer_order.dart';
import 'package:porco_eats/models/enums/order_status.dart';
import 'package:porco_eats/shared/services/app_remember_me.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';

class DashboardOrderController extends ChangeNotifier {
  DashboardOrderController({AppPreferences? preferences})
    : _preferences = preferences ?? AppPreferences();

  final AppPreferences _preferences;
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

  Future<void> loadOrders() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      _orders = await _preferences.loadOrders();
    } catch (error) {
      errorMessage = 'Não foi possível carregar os pedidos: $error';
    } finally {
      isLoading = false;
      notifyListeners();
    }
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
