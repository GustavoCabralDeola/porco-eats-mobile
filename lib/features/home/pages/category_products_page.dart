import 'package:flutter/material.dart';
import 'package:porco_eats/features/cart/pages/cart_page.dart';
import 'package:porco_eats/features/home/controllers/home_controller.dart';
import 'package:porco_eats/features/home/widgets/product_details_sheet.dart';
import 'package:porco_eats/models/product.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:porco_eats/shared/widgets/app_product_card.dart';
import 'package:provider/provider.dart';

class CategoryProductsPage extends StatefulWidget {
  const CategoryProductsPage({super.key, required this.categoryName});

  static const String route = '/category-products';

  final String categoryName;

  @override
  State<CategoryProductsPage> createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends State<CategoryProductsPage> {
  String _searchText = '';
  String? _selectedRestaurant;

  @override
  Widget build(BuildContext context) {
    final categoryProducts = context
        .watch<HomeController>()
        .productsForCategory(widget.categoryName);
    final restaurants = categoryProducts
        .map((product) => product.restaurant)
        .toSet()
        .toList()
      ..sort();
    final products = _filterProducts(categoryProducts);

    return Scaffold(
      backgroundColor: AppColors.brownWhite,
      appBar: AppBar(
        backgroundColor: AppColors.darkBrown,
        foregroundColor: AppColors.fullWhite,
        title: Text(widget.categoryName),
        actions: [
          IconButton(
            tooltip: 'Abrir carrinho',
            onPressed: () => Navigator.pushNamed(context, CartPage.route),
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchField(),
          if (restaurants.length > 1) _buildRestaurantFilter(restaurants),
          Expanded(child: _buildProductGrid(products)),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: TextField(
        onChanged: (value) => setState(() => _searchText = value),
        decoration: InputDecoration(
          hintText: 'Buscar nesta categoria',
          prefixIcon: const Icon(Icons.search, color: AppColors.darkBrown),
          filled: true,
          fillColor: AppColors.fullWhite,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.borderInputColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.borderInputColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.yellowAgility),
          ),
        ),
      ),
    );
  }

  Widget _buildRestaurantFilter(List<String> restaurants) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: DropdownButtonFormField<String>(
        key: ValueKey(_selectedRestaurant),
        initialValue: _selectedRestaurant,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: 'Restaurante',
          prefixIcon: const Icon(
            Icons.storefront_outlined,
            color: AppColors.darkBrown,
          ),
          filled: true,
          fillColor: AppColors.fullWhite,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.borderInputColor),
          ),
        ),
        items: [
          const DropdownMenuItem<String>(
            value: '',
            child: Text('Todos os restaurantes'),
          ),
          ...restaurants.map(
            (restaurant) => DropdownMenuItem<String>(
              value: restaurant,
              child: Text(restaurant),
            ),
          ),
        ],
        onChanged: (restaurant) {
          setState(() {
            _selectedRestaurant =
                restaurant == null || restaurant.isEmpty ? null : restaurant;
          });
        },
      ),
    );
  }

  Widget _buildProductGrid(List<Product> products) {
    if (products.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Não encontramos produtos com esses filtros.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.subTitle),
          ),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        mainAxisExtent: AppProductCard.cardHeight,
      ),
      itemBuilder: (context, index) {
        final product = products[index];
        return Center(
          child: AppProductCard(
            product: product,
            width: AppProductCard.cardWidth,
            height: AppProductCard.cardHeight,
            onTap: () => ProductDetailsSheet.show(context, product),
          ),
        );
      },
    );
  }

  List<Product> _filterProducts(List<Product> products) {
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
}
