import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:porco_eats/features/cart/controllers/cart_controller.dart';
import 'package:porco_eats/features/cart/pages/cart_page.dart';
import 'package:porco_eats/features/home/controllers/home_controller.dart';
import 'package:porco_eats/features/home/widgets/catalog_filter_dialog.dart';
import 'package:porco_eats/features/home/widgets/home_category_list.dart';
import 'package:porco_eats/features/home/pages/category_products_page.dart';
import 'package:porco_eats/features/home/widgets/product_catalog_section.dart';
import 'package:porco_eats/features/home/widgets/product_details_sheet.dart';
import 'package:porco_eats/features/home/widgets/recommended_stores_section.dart';
import 'package:porco_eats/features/login/controllers/login_controller.dart';
import 'package:porco_eats/models/enums/user_role.dart';
import 'package:porco_eats/models/product.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:porco_eats/shared/widgets/app_product_card.dart';
import 'package:porco_eats/shared/widgets/app_promo_carousel.dart';
import 'package:porco_eats/shared/widgets/app_search_field.dart';
import 'package:porco_eats/shared/widgets/app_text_style.dart';
import 'package:porco_eats/shared/widgets/app_home_navigation_bar_customer.dart';
import 'package:porco_eats/shared/widgets/app_home_navigation_bar_manager.dart';
import 'package:provider/provider.dart';

import '../../../shared/widgets/app_home_header.dart';

class HomePage extends StatefulWidget {
  static const String route = '/home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController _searchInput;

  @override
  void initState() {
    super.initState();
    _searchInput = TextEditingController(
      text: context.read<HomeController>().searchText,
    );
  }

  @override
  void dispose() {
    _searchInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Consumer<CartController>(
        builder: (context, cart, child) {
          if (cart.productsInCart.isEmpty) {
            return const SizedBox.shrink();
          }

          return FloatingActionButton.extended(
            onPressed: () => Navigator.pushNamed(context, CartPage.route),
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
        builder: (context, user, child) {
          return user.user?.role == UserRole.customer
              ? const AppHomeNavigationBarCustomer()
              : const AppHomeNavigationBarManager();
        },
      ),
      body: SingleChildScrollView(
        child: Consumer<HomeController>(
          builder: (context, home, child) => Column(
            children: [
              AppHomeHeader(),
              const SizedBox(height: 10),
              _buildSearchField(home),
              const SizedBox(height: 20),
              _buildCategories(home),
              const SizedBox(height: 20),
              _buildCatalog(home),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField(HomeController home) {
    return AppSearchField(
      hintText: 'O que você deseja comer hoje?',
      enableFilter: true,
      controller: _searchInput,
      onChanged: home.setSearchText,
      onFilterPressed: () => CatalogFilterDialog.show(
        context: context,
        selectedCategories: home.selectedCategories,
        onApply: home.setSelectedCategories,
      ),
    );
  }

  Widget _buildCategories(HomeController home) {
    return HomeCategoryList(
      selectedCategories: home.selectedCategories,
      onCategoryPressed: (category) {
        Navigator.pushNamed(
          context,
          CategoryProductsPage.route,
          arguments: category,
        );
      },
    );
  }

  Widget _buildCatalog(HomeController home) {
    if (home.hasCatalogFilters) {
      return ProductCatalogSection(
        title: home.selectedCategories.isEmpty
            ? 'Resultados da busca'
            : 'Resultados do filtro',
        products: home.filteredProducts,
        onProductTap: _openProduct,
        showGrid: true,
      );
    }

    return _buildRecommendations(home);
  }

  Widget _buildRecommendations(HomeController home) {
    return Column(
      children: [
        _buildBanners(),
        const SizedBox(height: 20),
        _buildOffers(home.offerProducts),
        const SizedBox(height: 20),
        ProductCatalogSection(
          title: 'Mais pedidos',
          products: home.mostOrderedProducts,
          onProductTap: _openProduct,
        ),
        const SizedBox(height: 24),
        RecommendedStoresSection(
          stores: home.recommendedStores,
          onStoreTap: (store) {
            home.setSelectedCategories({});
            _searchInput.text = store;
            home.setSearchText(store);
          },
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildBanners() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SizedBox(width: 10),
          AppPromoCarousel(
            banners: [
              'assets/images/porco_eats_images/carousel_images/hamburguerCarousel.png',
              'assets/images/porco_eats_images/carousel_images/pizzaCarousel.png',
              'assets/images/porco_eats_images/carousel_images/sushiCarousel.png',
            ],
          ),
          const SizedBox(width: 4),
          AppPromoCarousel(
            fit: BoxFit.contain,
            alignment: Alignment.centerLeft,
            width: 300,
            height: 127,
            banners: [
              'assets/images/porco_eats_images/carousel_images/firstcupomcarousel.png',
              'assets/images/porco_eats_images/carousel_images/secoundcupomcarousel.png',
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget _buildOffers(List<Product> products) {
    const badges = ['-20%', '♛ Mais pedido', '-15%'];
    const badgeColors = [Colors.red, Colors.orange, Colors.red];

    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 20),
            Text('Ofertas para você', style: AppTextStyle.sectionTitle),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 174,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            separatorBuilder: (context, index) => const SizedBox(width: 32),
            itemBuilder: (context, index) {
              final product = products[index];
              return AppProductCard(
                product: product,
                badgeLabel: badges[index],
                badgeColor: badgeColors[index],
                onTap: () => _openProduct(product),
              );
            },
          ),
        ),
      ],
    );
  }

  void _openProduct(Product product) {
    ProductDetailsSheet.show(context, product);
  }
}
