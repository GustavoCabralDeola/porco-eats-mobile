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

  // Future<void> getCategories() async {
  //   changeCategoriesState(CategoriesViewState.loading);
  //   await Future.delayed(Duration(seconds: 3));
  //   try {
  //     //deserializa e popula a nossa lista de categorias
  //     listCategories = mockJson.categoriesJson.map((item) {
  //       return Category.fromJson(item);
  //     }).toList();
  //     print(categoriesViewState);
  //     changeCategoriesState(CategoriesViewState.sucess);
  //     print(categoriesViewState);
  //   } catch (e) {
  //     //caso der erro na deserialização, emite o erro para a tela tratar
  //     changeCategoriesState(CategoriesViewState.error);
  //   }
  // }

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
