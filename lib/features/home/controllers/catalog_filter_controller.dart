import 'package:flutter/foundation.dart' show ChangeNotifier;

class CatalogFilterController extends ChangeNotifier {
  CatalogFilterController(Set<String> selectedCategories)
    : _selectedCategories = Set<String>.from(selectedCategories);

  final Set<String> _selectedCategories;

  Set<String> get selectedCategories =>
      Set<String>.unmodifiable(_selectedCategories);

  void toggleCategory(String category) {
    if (!_selectedCategories.add(category)) {
      _selectedCategories.remove(category);
    }

    notifyListeners();
  }

  void clearCategories() {
    if (_selectedCategories.isEmpty) return;

    _selectedCategories.clear();
    notifyListeners();
  }
}
