import 'package:flutter/material.dart';
import 'package:porco_eats/features/cart/pages/cart_page.dart';
import 'package:porco_eats/features/home/controllers/category_products_controller.dart';
import 'package:porco_eats/features/home/controllers/home_controller.dart';
import 'package:porco_eats/features/home/widgets/product_details_sheet.dart';
import 'package:porco_eats/models/product.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:porco_eats/shared/widgets/app_product_card.dart';
import 'package:provider/provider.dart';

class CategoryProductsPage extends StatelessWidget {
  const CategoryProductsPage({super.key, required this.categoryName});

  static const String route = '/category-products';

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CategoryProductsController(),
      child: _CategoryProductsPageContent(categoryName: categoryName),
    );
  }
}

class _CategoryProductsPageContent extends StatelessWidget {
  const _CategoryProductsPageContent({required this.categoryName});

  final String categoryName;

  @override
  Widget build(BuildContext context) {
    final categoryProducts = context
        .watch<HomeController>()
        .productsForCategory(categoryName);
    final controller = context.watch<CategoryProductsController>();
    final restaurants = categoryProducts
        .map((product) => product.restaurant)
        .toSet()
        .toList()
      ..sort();
    final products = controller.filterProducts(categoryProducts);

    return Scaffold(
      backgroundColor: AppColors.brownWhite,
      appBar: AppBar(
        backgroundColor: AppColors.darkBrown,
        foregroundColor: AppColors.fullWhite,
        title: Text(categoryName),
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
          _buildSearchField(context, controller),
          if (restaurants.length > 1)
            _buildRestaurantFilter(context, controller, restaurants),
          Expanded(child: _buildProductGrid(context, products)),
        ],
      ),
    );
  }

  Widget _buildSearchField(
    BuildContext context,
    CategoryProductsController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: TextField(
        onChanged: controller.setSearchText,
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

  Widget _buildRestaurantFilter(
    BuildContext context,
    CategoryProductsController controller,
    List<String> restaurants,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: DropdownButtonFormField<String>(
        key: ValueKey(controller.selectedRestaurant),
        initialValue: controller.selectedRestaurant,
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
        onChanged: controller.setSelectedRestaurant,
      ),
    );
  }

  Widget _buildProductGrid(BuildContext context, List<Product> products) {
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
}
