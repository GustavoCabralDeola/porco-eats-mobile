import 'package:flutter/material.dart';
import 'package:porco_eats/features/customer_order/controllers/customer_order_controller.dart';
import 'package:porco_eats/models/customer_order.dart';
import 'package:porco_eats/models/enums/order_status.dart';
import 'package:porco_eats/models/product.dart';
import 'package:porco_eats/models/user.dart';

class CartController extends ChangeNotifier {
  final List<Product> productsInCart = [];
  bool isLoading = false;

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

  void changeIsLoading(bool value) {
    isLoading = value;
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

  Future<CustomerOrder?> checkout(
    User user,
    CustomerOrderController orderController,
  ) async {
    if (productsInCart.isEmpty) {
      return null;
    }

    changeIsLoading(true);

    try {
      final order = CustomerOrder(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        products: List<Product>.from(productsInCart),
        total: totalPrice,
        status: OrderStatus.received,
        quantity: productsInCart.length,
        customerName: user.name.trim(),
        customerEmail: user.email.trim(),
        createdAt: DateTime.now(),
      );

      await Future.delayed(const Duration(seconds: 2));
      await orderController.addOrder(order);

      clearCart();

      return order;
    } finally {
      changeIsLoading(false);
    }
  }
}
