import 'package:flutter/material.dart';
import 'package:porco_eats/features/home/controllers/home_controller.dart';
import 'package:porco_eats/features/login/controllers/login_controller.dart';
import 'package:porco_eats/models/enums/user_role.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:porco_eats/shared/widgets/navigation/app_home_navigation_bar_customer.dart';
import 'package:porco_eats/shared/widgets/app_product_bottom_sheet.dart';
import 'package:porco_eats/shared/widgets/app_product_card.dart';
import 'package:porco_eats/shared/widgets/navigation/app_home_navigation_bar_manager.dart';
import 'package:provider/provider.dart';

class CategoryProductsPage extends StatefulWidget {
  static const route = '/category-products';

  const CategoryProductsPage({super.key, required this.categoryName});

  final String categoryName;

  @override
  State<CategoryProductsPage> createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends State<CategoryProductsPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  String? _selectedRestaurant;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brownWhite,
      appBar: AppBar(
        backgroundColor: AppColors.brownWhite,
        foregroundColor: AppColors.darkBrown,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(widget.categoryName),
      ),
      bottomNavigationBar: Consumer<LoginController>(
        builder: (context, controller, child) {
          return controller.user?.role == UserRole.customer
              ? const AppHomeNavigationBarCustomer()
              : const AppHomeNavigationBarManager();
        },
      ),
      body: Consumer<HomeController>(
        builder: (context, controller, child) {
          final categoryProducts = controller.productsInCategory(
            widget.categoryName,
          );

          if (categoryProducts.isEmpty) {
            return const Center(child: Text('Nenhum produto encontrado.'));
          }

          final restaurants =
              categoryProducts
                  .map((product) => product.restaurant)
                  .toSet()
                  .toList()
                ..sort();
          final query = _searchText.trim().toLowerCase();
          final products = categoryProducts.where((product) {
            final matchesRestaurant =
                _selectedRestaurant == null ||
                product.restaurant == _selectedRestaurant;
            final matchesSearch =
                query.isEmpty ||
                product.name.toLowerCase().contains(query) ||
                product.restaurant.toLowerCase().contains(query);
            return matchesRestaurant && matchesSearch;
          }).toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) => setState(() => _searchText = value),
                  decoration: InputDecoration(
                    hintText: 'Buscar nesta categoria',
                    prefixIcon: const Icon(
                      Icons.search,
                      color: AppColors.darkBrown,
                    ),
                    suffixIcon: _searchText.isEmpty
                        ? null
                        : IconButton(
                            tooltip: 'Limpar busca',
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchText = '');
                            },
                            icon: const Icon(Icons.close),
                          ),
                    filled: true,
                    fillColor: AppColors.fullWhite,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: AppColors.borderInputColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: AppColors.borderInputColor,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(
                        color: AppColors.yellowAgility,
                      ),
                    ),
                  ),
                ),
              ),
              if (restaurants.length > 1)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: DropdownButtonFormField<String>(
                    key: ValueKey(_selectedRestaurant),
                    initialValue: _selectedRestaurant ?? '',
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
                        borderSide: const BorderSide(
                          color: AppColors.borderInputColor,
                        ),
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
                    onChanged: (restaurant) => setState(
                      () => _selectedRestaurant = restaurant?.isEmpty == true
                          ? null
                          : restaurant,
                    ),
                  ),
                ),
              Expanded(
                child: products.isEmpty
                    ? const Center(
                        child: Text(
                          'Não encontramos produtos com esses filtros.',
                          textAlign: TextAlign.center,
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 180,
                              mainAxisExtent: 190,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 16,
                            ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return AppProductCard(
                            product: product,
                            onTap: () =>
                                showProductBottomSheet(context, product),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
