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

class CategoryProductsPage extends StatelessWidget {
  static const route = '/category-products';

  const CategoryProductsPage({super.key, required this.categoryName});

  final String categoryName;

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
        title: Text(categoryName),
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
          final products = controller.productsInCategory(categoryName);

          if (products.isEmpty) {
            return const Center(child: Text('Nenhum produto encontrado.'));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
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
                onTap: () => showProductBottomSheet(context, product),
              );
            },
          );
        },
      ),
    );
  }
}
