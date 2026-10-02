import 'package:flutter/material.dart';
import 'package:porco_eats/models/customer_order.dart';
import 'package:porco_eats/models/enums/order_status.dart';
import 'package:porco_eats/models/product.dart';
import 'package:porco_eats/shared/services/app_remember_me.dart';

class CartController extends ChangeNotifier {
  final AppPreferences _preferences;
  final List<Product> productsInCart = [];
  List<CustomerOrder> orders = [];

  CartController({AppPreferences? preferences})
    : _preferences = preferences ?? AppPreferences() {
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    orders = await _preferences.loadOrders();
    notifyListeners();
  }

  Future<void> _saveOrders() async {
    await _preferences.saveOrders(orders);
    notifyListeners();
  }

  void addToCart(Product product) {
    productsInCart.add(product);
    notifyListeners();
  }

  int getQuantity(Product product) {
    return productsInCart.where((item) => item.id == product.id).length;
  }

  void increaseQuantity(Product product) {
    addToCart(product);
  }

  void decreaseQuantity(Product product) {
    final index = productsInCart.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      productsInCart.removeAt(index);
      notifyListeners();
    }
  }

  void removeFromCart(Product product) {
    productsInCart.remove(product);
    notifyListeners();
  }

  double get totalPrice {
    return productsInCart.fold(0.0, (total, product) => total + product.price);
  }

  bool isProductInCart(Product product) {
    return getQuantity(product) > 0;
  }

  void clearCart() {
    productsInCart.clear();
    notifyListeners();
  }

  Future<void> checkout() async {
    if (productsInCart.isEmpty) {
      return;
    }

    final order = CustomerOrder(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      products: List<Product>.from(productsInCart),
      total: totalPrice,
      status: OrderStatus.received,
      quantity: productsInCart.length,
    );

    orders.insert(0, order);
    await _saveOrders();
    clearCart();
  }
}
