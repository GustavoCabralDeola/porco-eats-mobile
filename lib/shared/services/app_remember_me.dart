import 'dart:convert';

import 'package:porco_eats/models/customer_order.dart';
import 'package:porco_eats/models/product.dart';
import 'package:porco_eats/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static const _userKey = 'remembered_user';
  static const _registeredUsersKey = 'registered_users';
  static const _productsKey = 'products';
  static const _ordersKey = 'orders';

  final SharedPreferencesAsync _preferences;

  AppPreferences({SharedPreferencesAsync? preferences})
    : _preferences = preferences ?? SharedPreferencesAsync();

  Future<void> saveUser(User user) {
    return _preferences.setString(_userKey, jsonEncode(user.toJson()));
  }

  Future<User?> loadUser() async {
    final value = await _preferences.getString(_userKey);
    if (value == null) return null;

    try {
      return User.fromJson(jsonDecode(value) as Map<String, dynamic>);
    } on FormatException {
      await clearUser();
      return null;
    } on TypeError {
      await clearUser();
      return null;
    }
  }

  Future<void> clearUser() => _preferences.remove(_userKey);

  // Future<void> saveRegisteredUser(User user) {
  //   return _preferences.setString(
  //     _registeredUsersKey,
  //     jsonEncode(user.toJson()),
  //   );
  // }

  Future<User?> loadRegisteredUser() async {
    final value = await _preferences.getString(_registeredUsersKey);
    if (value == null) return null;

    try {
      return User.fromJson(jsonDecode(value) as Map<String, dynamic>);
    } on FormatException {
      await _preferences.remove(_registeredUsersKey);
      return null;
    } on TypeError {
      await _preferences.remove(_registeredUsersKey);
      return null;
    }
  }

  Future<void> clearRegisteredUser() =>
      _preferences.remove(_registeredUsersKey);

  Future<void> saveRegisteredUsers(List<User> users) {
    final value = jsonEncode(users.map((user) => user.toJson()).toList());
    return _preferences.setString(_registeredUsersKey, value);
  }

  Future<List<User>> loadRegisteredUsers() async {
    final value = await _preferences.getString(_registeredUsersKey);
    if (value == null) return [];

    try {
      final users = jsonDecode(value) as List<dynamic>;
      return users
          .map((user) => User.fromJson(user as Map<String, dynamic>))
          .toList(growable: false);
    } on FormatException {
      await _preferences.remove(_registeredUsersKey);
      return [];
    } on TypeError {
      await _preferences.remove(_registeredUsersKey);
      return [];
    }
  }

  Future<void> clearRegisteredUsers() =>
      _preferences.remove(_registeredUsersKey);

  Future<void> saveProducts(List<Product> products) {
    final value = jsonEncode(
      products.map((product) => product.toJson()).toList(),
    );
    return _preferences.setString(_productsKey, value);
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
