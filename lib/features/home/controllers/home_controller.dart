import 'dart:async';

import 'package:flutter/material.dart';
import 'package:porco_eats/models/category.dart';
import 'package:porco_eats/models/customer_order.dart';
import 'package:porco_eats/models/product.dart';
import 'package:porco_eats/shared/mock.dart';

enum CategoriesViewState { loading, sucess, error }

enum ProductsViewState { loading, sucess, error }

class HomeController extends ChangeNotifier {
  Timer? _initialSkeletonTimer;

  bool _isShowingInitialSkeleton = false;
  bool _hasShownInitialSkeleton = false;

  final TextEditingController searchController = TextEditingController();

  String _searchText = '';

  List<Category> listCategories = [];
  List<Product> listProducts = [];
  List<CustomerOrder> listCustomerOrdersInCart = [];

  Mocks mockJson = Mocks();

  CategoriesViewState categoriesViewState = CategoriesViewState.loading;

  ProductsViewState productsViewState = ProductsViewState.loading;

  List<Product> get offerProducts => _productsByIds([1, 8, 12]);

  List<Product> get mostOrderedProducts => _productsByIds([17, 1, 21]);

  String get searchText => _searchText;

  bool get isSearching => _searchText.trim().isNotEmpty;

  List<Product> get filteredProducts {
    final query = _searchText.trim().toLowerCase();

    if (query.isEmpty) {
      return listProducts;
    }

    return listProducts.where((product) {
      return product.name.toLowerCase().contains(query) ||
          product.restaurant.toLowerCase().contains(query) ||
          product.category.toLowerCase().contains(query);
    }).toList();
  }

  List<Product> _productsByIds(List<int> ids) {
    return ids
        .map(
          (id) => Product.fromJson(
            mockJson.productsJson.firstWhere((item) => item['id'] == id),
          ),
        )
        .toList();
  }

  List<Product> productsInCategory(String categoryName) {
    final category = categoryName == 'Pizzas' ? 'Pizza' : categoryName;

    return mockJson.productsJson
        .where((item) => item['category'] == category)
        .map(Product.fromJson)
        .toList();
  }

  bool get isShowingInitialSkeleton => _isShowingInitialSkeleton;

  void searchProducts(String value) {
    _searchText = value;
    notifyListeners();
  }

  void clearSearch() {
    searchController.clear();
    _searchText = '';
    notifyListeners();
  }

  void showInitialSkeleton() {
    if (_isShowingInitialSkeleton || _hasShownInitialSkeleton) return;

    _hasShownInitialSkeleton = true;
    _isShowingInitialSkeleton = true;
    notifyListeners();

    _initialSkeletonTimer = Timer(const Duration(seconds: 3), () {
      _isShowingInitialSkeleton = false;
      _initialSkeletonTimer = null;
      notifyListeners();
    });
  }

  void changeCategoriesState(CategoriesViewState state) {
    categoriesViewState = state;
    notifyListeners();
  }

  void changeProductsState(ProductsViewState state) {
    productsViewState = state;
    notifyListeners();
  }

  Future<void> getProducts() async {
    changeProductsState(ProductsViewState.loading);

    await Future.delayed(const Duration(seconds: 3));

    try {
      listProducts = mockJson.productsJson.map((item) {
        return Product.fromJson(item);
      }).toList();

      changeProductsState(ProductsViewState.sucess);
      print(productsViewState);
    } catch (e) {
      changeProductsState(ProductsViewState.error);
      print(productsViewState);
    }
  }

  @override
  void dispose() {
    _initialSkeletonTimer?.cancel();
    searchController.dispose();
    super.dispose();
  }
}
