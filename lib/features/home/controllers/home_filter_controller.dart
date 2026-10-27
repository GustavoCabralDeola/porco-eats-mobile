import 'package:flutter/foundation.dart';

class HomeFilterController extends ChangeNotifier {
  HomeFilterController({Set<String> initialCategories = const {}})
    : _selectedCategories = {...initialCategories};

  static const categories = <String>[
    'Lanches',
    'Pizzas',
    'Sushi',
    'Executivos',
    'Porções',
    'Bebidas',
    'Sobremesas',
  ];

  static const _categoryValues = <String, String>{'Pizzas': 'Pizza'};
  final Set<String> _selectedCategories;

  Set<String> get selectedCategories => Set.unmodifiable(_selectedCategories);
  int get selectedCount => _selectedCategories.length;
  bool isSelected(String category) => _selectedCategories.contains(category);

  void toggleCategory(String category) {
    if (!_selectedCategories.add(category)) {
      _selectedCategories.remove(category);
    }
    notifyListeners();
  }

  void clear() {
    if (_selectedCategories.isEmpty) return;
    _selectedCategories.clear();
    notifyListeners();
  }

  static String productCategory(String category) =>
      _categoryValues[category] ?? category;
}
