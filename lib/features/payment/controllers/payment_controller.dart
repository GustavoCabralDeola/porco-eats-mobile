import 'package:flutter/material.dart';

class PaymentController extends ChangeNotifier {
  String selectedPayment = 'Pix';
  final List<String> addresses = ['Rua das Flores, 123'];
  int selectedAddressIndex = 0;

  String get currentAddress => addresses[selectedAddressIndex];

  void setSelectedPayment(String payment) {
    selectedPayment = payment;
    notifyListeners();
  }

  void setSelectedAddress(int index) {
    if (index < 0 || index >= addresses.length) return;
    selectedAddressIndex = index;
    notifyListeners();
  }

  void setAddress(String newAddress) {
    final value = newAddress.trim();
    if (value.isEmpty) return;
    addresses.add(value);
    selectedAddressIndex = addresses.length - 1;
    notifyListeners();
  }
}
