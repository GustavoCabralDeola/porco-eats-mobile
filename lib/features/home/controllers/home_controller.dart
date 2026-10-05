import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:porco_eats/models/product.dart';
import 'package:porco_eats/shared/mock.dart';

class HomeController extends ChangeNotifier {
  HomeController() {
    _products = Mocks().productsJson
        .map(Product.fromJson)
        .toList(growable: false);
  }

  static const List<int> _offerProductIds = [1, 8, 12];
  static const List<int> _mostOrderedProductIds = [17, 1, 21];

  static const List<String> availableCategories = [
    'Lanches',
    'Pizzas',
    'Sushi',
    'Executivos',
    'Porções',
    'Bebidas',
  ];

  late final List<Product> _products;

  String _searchText = '';
  final Set<String> _selectedCategories = {};

  String get searchText => _searchText;
  Set<String> get selectedCategories =>
      Set<String>.unmodifiable(_selectedCategories);

  List<Product> get offerProducts => _findProductsByIds(_offerProductIds);
  List<Product> get mostOrderedProducts =>
      _findProductsByIds(_mostOrderedProductIds);
  List<String> get recommendedStores =>
      _products.map((product) => product.restaurant).toSet().toList()..sort();

  List<Product> productsForCategory(String category) {
    return _products
        .where(
          (product) =>
              _normalizeCategory(product.category) ==
              _normalizeCategory(category),
        )
        .toList(growable: false);
  }

  bool get hasCatalogFilters =>
      _searchText.trim().isNotEmpty || _selectedCategories.isNotEmpty;

  List<Product> get filteredProducts {
    final visibleProducts = _products
        .where(_matchesSelectedCategory)
        .where(_matchesSearch)
        .toList(growable: false);

    final offers = visibleProducts.where(
      (product) => _offerProductIds.contains(product.id),
    );
    final otherProducts = visibleProducts.where(
      (product) => !_offerProductIds.contains(product.id),
    );

    return [...offers, ...otherProducts];
  }

  List<Product> _findProductsByIds(List<int> ids) {
    return ids
        .map((id) => _products.firstWhere((product) => product.id == id))
        .toList(growable: false);
  }

  bool _matchesSelectedCategory(Product product) {
    if (_selectedCategories.isEmpty) return true;

    return _selectedCategories.any(
      (category) =>
          _normalizeCategory(product.category) == _normalizeCategory(category),
    );
  }

  bool _matchesSearch(Product product) {
    final searchText = _searchText.trim().toLowerCase();
    if (searchText.isEmpty) return true;

    return product.name.toLowerCase().contains(searchText) ||
        product.restaurant.toLowerCase().contains(searchText) ||
        (product.description?.toLowerCase().contains(searchText) ?? false);
  }

  String _normalizeCategory(String category) {
    final normalizedCategory = category.trim().toLowerCase();
    return normalizedCategory == 'pizzas' ? 'pizza' : normalizedCategory;
  }

  void setSearchText(String value) {
    if (_searchText == value) return;

    _searchText = value;
    notifyListeners();
  }

  void toggleCategory(String category) {
    if (!_selectedCategories.add(category)) {
      _selectedCategories.remove(category);
    }

    notifyListeners();
  }

  void setSelectedCategories(Set<String> categories) {
    final hasSameCategories =
        _selectedCategories.length == categories.length &&
        _selectedCategories.containsAll(categories);
    if (hasSameCategories) return;

    _selectedCategories
      ..clear()
      ..addAll(categories);
    notifyListeners();
  }

  void clearCatalogFilters() {
    if (_searchText.isEmpty && _selectedCategories.isEmpty) return;

    _searchText = '';
    _selectedCategories.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    _initialSkeletonTimer?.cancel();
    super.dispose();
  }
}
