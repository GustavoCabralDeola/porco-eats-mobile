import 'package:flutter/foundation.dart';
import 'package:porco_eats/models/product.dart';
import 'package:porco_eats/shared/mock.dart';

class HomeSearchFilterController extends ChangeNotifier {
  final Mocks _mocks = Mocks();
  String _searchText = '';
  Set<String> _selectedCategories = {};

  String get searchText => _searchText;

  Set<String> get selectedCategories => Set.unmodifiable(_selectedCategories);

  int get activeProductFilterCount => _selectedCategories.length;

  List<String> get availableProductCategories => _mocks.productsJson
      .map((product) => product['category'] as String)
      .toSet()
      .toList();

  void setSearchText(String value) {
    if (_searchText == value) return;

    _searchText = value;
    notifyListeners();
  }

  void setSelectedCategories(Set<String> categories) {
    if (_selectedCategories.length == categories.length &&
        _selectedCategories.containsAll(categories)) {
      return;
    }

    _selectedCategories = Set.of(categories);
    notifyListeners();
  }

  void clearProductFilters() => setSelectedCategories({});

  List<Product> filterProducts(List<Product> products) {
    final query = _searchText.trim().toLowerCase();
    return products.where((product) {
      final matchesCategory =
          _selectedCategories.isEmpty ||
          _selectedCategories.contains(product.category);
      final matchesSearch =
          query.isEmpty ||
          product.name.toLowerCase().contains(query) ||
          product.restaurant.toLowerCase().contains(query) ||
          (product.description?.toLowerCase().contains(query) ?? false);
      return matchesCategory && matchesSearch;
    }).toList(growable: false);
  }
}
