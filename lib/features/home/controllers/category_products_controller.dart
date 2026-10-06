import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:porco_eats/models/product.dart';

class CategoryProductsController extends ChangeNotifier {
  String _searchText = '';
  String? _selectedRestaurant;

  String get searchText => _searchText;
  String? get selectedRestaurant => _selectedRestaurant;

  List<Product> filterProducts(List<Product> products) {
    final query = _searchText.trim().toLowerCase();
    return products.where((product) {
      final matchesRestaurant =
          _selectedRestaurant == null ||
          product.restaurant == _selectedRestaurant;
      final matchesSearch =
          query.isEmpty ||
          product.name.toLowerCase().contains(query) ||
          product.restaurant.toLowerCase().contains(query);
      return matchesRestaurant && matchesSearch;
    }).toList(growable: false);
  }

  void setSearchText(String value) {
    if (_searchText == value) return;

    _searchText = value;
    notifyListeners();
  }

  void setSelectedRestaurant(String? restaurant) {
    final selectedRestaurant = restaurant?.isEmpty == true ? null : restaurant;
    if (_selectedRestaurant == selectedRestaurant) return;

    _selectedRestaurant = selectedRestaurant;
    notifyListeners();
  }
}
