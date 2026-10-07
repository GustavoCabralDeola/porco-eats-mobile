import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:porco_eats/features/cart/controllers/cart_controller.dart';
import 'package:porco_eats/features/cart/pages/cart_page.dart';
import 'package:porco_eats/features/home/controllers/home_controller.dart';
import 'package:porco_eats/features/home/controllers/home_search_filter_controller.dart';
import 'package:porco_eats/features/home/widgets/app_home_banners_row.dart';
import 'package:porco_eats/features/home/widgets/app_home_categories_row.dart';
import 'package:porco_eats/features/home/widgets/app_home_products_section.dart';
import 'package:porco_eats/features/home/widgets/home_skeleton_loaders.dart';
import 'package:porco_eats/features/login/controllers/login_controller.dart';
import 'package:porco_eats/models/enums/user_role.dart';
import 'package:porco_eats/models/product.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:porco_eats/shared/widgets/app_search_field.dart';
import 'package:porco_eats/shared/widgets/navigation/app_home_navigation_bar_customer.dart';
import 'package:porco_eats/shared/widgets/navigation/app_home_navigation_bar_manager.dart';
import 'package:provider/provider.dart';

import '../../../shared/widgets/headers/app_home_header.dart';

class HomePage extends StatelessWidget {
  static String route = '/home';

  const HomePage({super.key, this.showInitialSkeleton = false});

  final bool showInitialSkeleton;

  @override
  Widget build(BuildContext context) {
    if (showInitialSkeleton) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<HomeController>().showInitialSkeleton();
      });
    }

    final isShowingInitialSkeleton = context
        .watch<HomeController>()
        .isShowingInitialSkeleton;

    return Scaffold(
      floatingActionButton: Consumer<CartController>(
        builder: (context, controller, child) {
          if (controller.productsInCart.isEmpty) {
            return SizedBox.shrink();
          }

          return FloatingActionButton.extended(
            onPressed: () {
              Navigator.pushNamed(context, CartPage.route);
            },
            backgroundColor: AppColors.redDelivery,
            foregroundColor: AppColors.fullWhite,
            icon: const Icon(Icons.shopping_cart),
            label: Text(
              'Ver carrinho',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: AppColors.fullWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Consumer<LoginController>(
        builder: (context, controller, child) {
          return controller.user?.role == UserRole.customer
              ? AppHomeNavigationBarCustomer()
              : AppHomeNavigationBarManager();
        },
      ),
      body: isShowingInitialSkeleton
          ? const HomePageSkeletonLoader()
          : SingleChildScrollView(
              child: Consumer<HomeController>(
                builder: (context, controller, child) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppHomeHeader(),
                    SizedBox(height: 10),
                    AppSearchField(
                      hintText: 'O que você deseja comer hoje?',
                      enableFilter: true,
                    ),
                    SizedBox(height: 20),
                    AppHomeCategoriesRow(),
                    SizedBox(height: 20),
                    AppHomeBannersRow(),
                    SizedBox(height: 20),
                    AppHomeProductsSection(
                      title: 'Ofertas para você',
                      products: context
                          .watch<HomeSearchFilterController>()
                          .filterProducts(controller.offerProducts),
                      badgeLabels: ['-20%', '♛ Mais pedido', '-15%'],
                      badgeColors: [Colors.red, Colors.orange, Colors.red],
                      onProductTap: (product) =>
                          _showProductBottomSheet(context, product),
                    ),
                    SizedBox(height: 20),
                    AppHomeProductsSection(
                      title: 'Mais pedidos',
                      products: context
                          .watch<HomeSearchFilterController>()
                          .filterProducts(controller.mostOrderedProducts),
                      onProductTap: (product) =>
                          _showProductBottomSheet(context, product),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }
}

// class CategoryProductsPage extends StatelessWidget {
//   static const route = '/category-products';

//   const CategoryProductsPage({super.key, required this.categoryName});

//   final String categoryName;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.brownWhite,
//       appBar: AppBar(
//         backgroundColor: AppColors.brownWhite,
//         foregroundColor: AppColors.darkBrown,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () => Navigator.of(context).pop(),
//           icon: const Icon(Icons.arrow_back),
//         ),
//         title: Text(categoryName),
//       ),
//       bottomNavigationBar: Consumer<LoginController>(
//         builder: (context, controller, child) {
//           return controller.user?.role == UserRole.customer
//               ? AppHomeNavigationBarCustomer()
//               : AppHomeNavigationBarManager();
//         },
//       ),
//       body: Consumer<HomeController>(
//         builder: (context, controller, child) {
//           final products = controller.productsInCategory(categoryName);

//           if (products.isEmpty) {
//             return const Center(child: Text('Nenhum produto encontrado.'));
//           }

//           return GridView.builder(
//             padding: const EdgeInsets.all(16),
//             gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//               maxCrossAxisExtent: 180,
//               mainAxisExtent: 190,
//               crossAxisSpacing: 12,
//               mainAxisSpacing: 16,
//             ),
//             itemCount: products.length,
//             itemBuilder: (context, index) {
//               final product = products[index];
//               return AppProductCard(
//                 product: product,
//                 onTap: () => _showProductBottomSheet(context, product),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

void _showProductBottomSheet(BuildContext context, Product product) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black87,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.3,
      maxChildSize: 0.7,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // PUXADOR
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // CONTEÚDO
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            _productDetailImage(product),
                            width: double.infinity,
                            height: 280,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                            cacheWidth: 1000,
                          ),
                        ),

                        const SizedBox(height: 20),

                        Text(
                          product.name,
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          product.restaurant,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              product.avaliation.toString(),
                              style: GoogleFonts.poppins(fontSize: 14),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        Text(
                          'Descrição',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          product.description ?? 'Sem descrição',
                          style: GoogleFonts.poppins(fontSize: 13),
                        ),

                        const SizedBox(height: 30),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'R\$ ${product.price.toStringAsFixed(2)}',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Consumer<CartController>(
                              builder: (context, controller, child) {
                                final quantity = controller.getQuantity(
                                  product,
                                );

                                return Row(
                                  children: [
                                    if (quantity > 0)
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.orange.shade50,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                controller.decreaseQuantity(
                                                  product,
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.remove,
                                                size: 18,
                                              ),
                                              color: Colors.orange,
                                              splashRadius: 18,
                                            ),

                                            Text(
                                              quantity.toString(),
                                              style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.orange,
                                              ),
                                            ),

                                            IconButton(
                                              onPressed: () {
                                                controller.increaseQuantity(
                                                  product,
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.add,
                                                size: 18,
                                              ),
                                              color: Colors.orange,
                                              splashRadius: 18,
                                            ),
                                          ],
                                        ),
                                      )
                                    else
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          controller.addToCart(product);

                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                '${product.name} adicionado ao carrinho!',
                                                style: GoogleFonts.poppins(),
                                              ),
                                              duration: const Duration(
                                                seconds: 2,
                                              ),
                                            ),
                                          );
                                        },
                                        icon: Icon(Icons.shopping_cart),
                                        label: Text('Adicionar'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.orange,
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 12,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              25,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

String _productDetailImage(Product product) {
  if (product.id == 8) {
    return 'assets/images/porco_eats_images/products/pizzacalabresa.jpg';
  }
  return product.imageUrl;
}
