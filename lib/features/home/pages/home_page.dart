import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:porco_eats/features/cart/controllers/cart_controller.dart';
import 'package:porco_eats/features/cart/pages/cart_page.dart';
import 'package:porco_eats/features/home/controllers/home_controller.dart';
import 'package:porco_eats/models/product.dart';
import 'package:porco_eats/shared/mock.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:porco_eats/shared/widgets/app_product_card.dart';
import 'package:porco_eats/shared/widgets/app_promo_carousel.dart';
import 'package:porco_eats/shared/widgets/app_search_field.dart';
import 'package:porco_eats/shared/widgets/app_text_style.dart';
import 'package:provider/provider.dart';

import '../../../shared/widgets/app_category_item.dart';
import '../../../shared/widgets/app_home_header.dart';

class HomePage extends StatelessWidget {
  static String route = '/home';

  const HomePage({super.key});

  List<Product> _productsByIds(List<int> ids) {
    final productsJson = Mocks().productsJson;
    return ids
        .map(
          (id) => Product.fromJson(
            productsJson.firstWhere((item) => item['id'] == id),
          ),
        )
        .toList();
  }

  List<Product> get offerProducts => _productsByIds([1, 8, 12]);

  List<Product> get mostOrderedProducts => _productsByIds([17, 1, 21]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, CartPage.route);
        },
        backgroundColor: AppColors.redDelivery,
        foregroundColor: AppColors.fullWhite,
        icon: Icon(Icons.shopping_cart),
        label: Text(
          'Ver carrinho',
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: AppColors.fullWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer<HomeController>(
          builder: (context, controller, child) => Column(
            children: [
              AppHomeHeader(),
              SizedBox(height: 10),
              AppSearchField(
                hintText: 'O que você deseja comer hoje?',
                enableFilter: true,
              ),
              SizedBox(height: 20),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    AppCategoryItem(
                      label: 'Lanches',
                      onTap: () {},
                      image:
                          'assets/images/porco_eats_images/categories_icons/hamburguerIcon.png',
                      imageWidth: 43,
                      imageHeight: 43,
                    ),

                    SizedBox(width: 10),

                    AppCategoryItem(
                      label: 'Pizzas',
                      onTap: () {},
                      image:
                          'assets/images/porco_eats_images/categories_icons/pizzaIcon.png',
                      imageWidth: 43,
                      imageHeight: 43,
                    ),

                    SizedBox(width: 10),

                    AppCategoryItem(
                      label: 'Sushi',
                      onTap: () {},
                      image:
                          'assets/images/porco_eats_images/categories_icons/sushiIcon.png',
                      imageWidth: 50,
                      imageHeight: 50,
                    ),

                    SizedBox(width: 10),

                    AppCategoryItem(
                      label: 'Executivos',
                      onTap: () {},
                      image:
                          'assets/images/porco_eats_images/categories_icons/executivoIcon.png',
                      imageWidth: 100,
                      imageHeight: 55,
                      scale: 1.5,
                    ),

                    SizedBox(width: 10),
                    AppCategoryItem(
                      label: 'Porções',
                      onTap: () {},
                      image:
                          'assets/images/porco_eats_images/categories_icons/porcoesIcon.png',
                      imageWidth: 74,
                      imageHeight: 58,
                    ),

                    SizedBox(width: 10),
                    AppCategoryItem(
                      label: 'Bebidas',
                      onTap: () {},
                      image:
                          'assets/images/porco_eats_images/categories_icons/bebidaIcon.png',
                      imageWidth: 60,
                      imageHeight: 80,
                    ),

                    SizedBox(width: 10),
                  ],
                ),
              ),

              SizedBox(height: 20),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    AppPromoCarousel(
                      banners: [
                        'assets/images/porco_eats_images/carousel_images/hamburguerCarousel.png',
                        'assets/images/porco_eats_images/carousel_images/pizzaCarousel.png',
                        'assets/images/porco_eats_images/carousel_images/sushiCarousel.png',
                      ],
                    ),
                    SizedBox(width: 4),
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
                    SizedBox(width: 10),
                  ],
                ),
              ),
              SizedBox(height: 20),

              Row(
                children: [
                  SizedBox(width: 20),
                  Text('Ofertas para você', style: AppTextStyle.sectionTitle),
                ],
              ),

              SizedBox(height: 20),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: 14),
                    ...List.generate(offerProducts.length, (index) {
                      final product = offerProducts[index];
                      final badges = ['-20%', '♛ Mais pedido', '-15%'];
                      final badgeColors = [
                        Colors.red,
                        Colors.orange,
                        Colors.red,
                      ];

                      return Padding(
                        padding: const EdgeInsets.only(right: 32),
                        child: AppProductCard(
                          product: product,
                          badgeLabel: badges[index],
                          badgeColor: badgeColors[index],
                          onTap: () =>
                              _showProductBottomSheet(context, product),
                        ),
                      );
                    }),
                    SizedBox(width: 14),
                  ],
                ),
              ),
              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20),
                  Container(
                    child: Text(
                      'Mais pedidos',
                      style: AppTextStyle.sectionTitle,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: 14),
                    ...List.generate(mostOrderedProducts.length, (index) {
                      final product = mostOrderedProducts[index];

                      return Padding(
                        padding: const EdgeInsets.only(right: 32),
                        child: AppProductCard(
                          product: product,
                          onTap: () =>
                              _showProductBottomSheet(context, product),
                        ),
                      );
                    }),
                    SizedBox(width: 14),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
                        // IMAGEM DO PRODUTO
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

                        // NOME
                        Text(
                          product.name,
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // RESTAURANTE
                        Text(
                          product.restaurant,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 12),

                        // AVALIAÇÃO
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

                        // DESCRIÇÃO
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

                        // PREÇO + CARRINHO
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
