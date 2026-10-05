import 'package:flutter/material.dart';
import 'package:porco_eats/models/category.dart';
import 'package:porco_eats/models/customer_order.dart';
import 'package:porco_eats/models/product.dart';
import 'package:porco_eats/shared/mock.dart';

enum CategoriesViewState { loading, sucess, error }

enum ProductsViewState { loading, sucess, error }

class HomeController extends ChangeNotifier {
  List<Category> listCategories = [];
  List<Product> listProducts = [];
  List<CustomerOrder> listCustomerOrdersInCart = [];

  Mocks mockJson = Mocks();

  List<Product> _productsByIds(List<int> ids) {
    return ids
        .map(
          (id) => Product.fromJson(
            mockJson.productsJson.firstWhere((item) => item['id'] == id),
          ),
        )
        .toList();
  }

  List<Product> get offerProducts => _productsByIds([1, 8, 12]);

  List<Product> get mostOrderedProducts => _productsByIds([17, 1, 21]);

  List<Product> productsInCategory(String categoryName) {
    final category = categoryName == 'Pizzas' ? 'Pizza' : categoryName;

    return mockJson.productsJson
        .where((item) => item['category'] == category)
        .map(Product.fromJson)
        .toList();
  }

  CategoriesViewState categoriesViewState = CategoriesViewState.loading;
  ProductsViewState productsViewState = ProductsViewState.loading;

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
}
