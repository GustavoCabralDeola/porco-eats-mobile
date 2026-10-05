import 'package:flutter/material.dart';
import 'package:porco_eats/models/enums/order_status.dart';

class OrderDetailsController extends ChangeNotifier {
  OrderDetailsController({required OrderStatus initialStatus})
    : _selectedStatus = initialStatus;

  OrderStatus _selectedStatus;

  OrderStatus get selectedStatus => _selectedStatus;

  void setSelectedStatus(OrderStatus status) {
    if (_selectedStatus == status) return;

    _selectedStatus = status;
    notifyListeners();
  }
}
