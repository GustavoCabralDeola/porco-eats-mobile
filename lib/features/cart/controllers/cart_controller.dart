import 'package:flutter/material.dart';
import 'package:porco_eats/models/customer_order.dart';
import 'package:porco_eats/models/enums/order_status.dart';
import 'package:porco_eats/models/product.dart';
import 'package:porco_eats/models/user.dart';
import 'package:porco_eats/shared/services/app_remember_me.dart';

class CartController extends ChangeNotifier {
  final AppPreferences _preferences;
  final List<Product> productsInCart = [];
  List<CustomerOrder> orders = [];

  CartController({AppPreferences? preferences})
    : _preferences = preferences ?? AppPreferences() {
    loadOrders();
  }

  List<Product> get uniqueProductsInCart {
    final uniqueProducts = <Product>[];
    final seenIds = <int>{};

    for (final product in productsInCart) {
      if (seenIds.add(product.id)) {
        uniqueProducts.add(product);
      }
    }

    return uniqueProducts;
  }

  Future<void> loadOrders() async {
    orders = List<CustomerOrder>.from(await _preferences.loadOrders());
    print(
      'Pedidos salvos no localStorage: ${orders.map((order) => order.toJson()).toList()}',
    );
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

  void updateObservation(Product product, String observation) {
    final index = productsInCart.indexWhere((item) => item.id == product.id);
    if (index != -1) {
      productsInCart[index] = productsInCart[index].copyWith(
        observation: observation,
      );
      notifyListeners();
    }
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

  Future<void> checkout(User user) async {
    if (productsInCart.isEmpty) {
      return;
    }

    final order = CustomerOrder(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      products: List<Product>.from(productsInCart),
      total: totalPrice,
      status: OrderStatus.received,
      quantity: productsInCart.length,
      customerName: user.name,
    );

    orders.insert(0, order);
    await _saveOrders();
    clearCart();
  }
}
