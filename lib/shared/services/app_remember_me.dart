import 'dart:convert';

import 'package:porco_eats/models/customer.dart';
import 'package:porco_eats/models/customer_order.dart';
import 'package:porco_eats/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static const _userKey = 'remembered_user';
  static const _productsKey = 'products';
  static const _ordersKey = 'orders';

  final SharedPreferencesAsync _preferences;

  AppPreferences({SharedPreferencesAsync? preferences})
    : _preferences = preferences ?? SharedPreferencesAsync();

  Future<void> saveUser(Customer user) {
    return _preferences.setString(_userKey, jsonEncode(user.toJson()));
  }

  Future<Customer?> loadUser() async {
    final value = await _preferences.getString(_userKey);
    if (value == null) return null;

    try {
      return Customer.fromJson(jsonDecode(value) as Map<String, dynamic>);
    } on FormatException {
      await clearUser();
      return null;
    } on TypeError {
      await clearUser();
      return null;
    }
  }

  Future<void> clearUser() => _preferences.remove(_userKey);

  Future<void> saveProducts(List<Product> products) {
    final value = jsonEncode(
      products.map((product) => product.toJson()).toList(),
    );
    return _preferences.setString(_productsKey, value);
  }

  Future<List<Product>> loadProducts() async {
    final value = await _preferences.getString(_productsKey);
    if (value == null) return [];

    try {
      final products = jsonDecode(value) as List<dynamic>;
      return products
          .map((product) => Product.fromJson(product as Map<String, dynamic>))
          .toList(growable: false);
    } on FormatException {
      await _preferences.remove(_productsKey);
      return [];
    } on TypeError {
      await _preferences.remove(_productsKey);
      return [];
    }
  }

  Future<void> saveOrders(List<CustomerOrder> orders) {
    final value = jsonEncode(orders.map((order) => order.toJson()).toList());
    return _preferences.setString(_ordersKey, value);
  }

  Future<List<CustomerOrder>> loadOrders() async {
    final value = await _preferences.getString(_ordersKey);
    if (value == null) return [];

    try {
      final orders = jsonDecode(value) as List<dynamic>;
      return orders
          .map((order) => CustomerOrder.fromJson(order as Map<String, dynamic>))
          .toList(growable: false);
    } on FormatException {
      await _preferences.remove(_ordersKey);
      return [];
    } on TypeError {
      await _preferences.remove(_ordersKey);
      return [];
    }
  }

  Future<void> clearOrders() => _preferences.remove(_ordersKey);
}
