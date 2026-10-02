import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:porco_eats/features/cart/controllers/cart_controller.dart';
import 'package:porco_eats/features/home/controllers/home_controller.dart';
import 'package:porco_eats/models/product.dart';
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

  // Mock data for "Ofertas para você"
  List<Product> get offerProducts => [
    Product(
      id: 4,
      name: 'X-Bacon Duplo',
      restaurant: 'Burger House',
      imageUrl:
          'assets/images/porco_eats_images/products/xbaconburgerhouse.png',
      price: 27.92,
      category: 'Lanches',
      avaliation: 4.8,
      description: 'Hambúrguer artesanal com dois discos de carne bovina',
    ),
    Product(
      id: 5,
      name: 'Pizza de Calabresa',
      restaurant: 'Pizza do chef',
      imageUrl: 'assets/images/porco_eats_images/products/pizzacalabresa.png',
      price: 76.41,
      category: 'Pizzas',
      avaliation: 4.7,
      description: 'Pizza tradicional com calabresa',
    ),
    Product(
      id: 6,
      name: 'Combo Sushi 60 peças',
      restaurant: 'Tokyo Express',
      imageUrl:
          'assets/images/porco_eats_images/carousel_images/sushiCarousel.png',
      price: 95.12,
      category: 'Sushi',
      avaliation: 4.9,
      description: 'Combo completo com 60 peças de sushi variado',
    ),
  ];

  // Mock data for "Mais pedidos"
  List<Product> get mostOrderedProducts => [
    Product(
      id: 1,
      name: 'Frango Grelinhado',
      restaurant: 'Frango Grill',
      imageUrl: 'assets/images/porco_eats_images/products/frangogrelhado.png',
      price: 42.90,
      category: 'Lanches',
      avaliation: 4.8,
      description: 'Frango grelhado com acompanhamentos',
    ),
    Product(
      id: 2,
      name: 'X-Bacon Duplo',
      restaurant: 'Burger House',
      imageUrl:
          'assets/images/porco_eats_images/products/xbaconburgerhouse.png',
      price: 27.92,
      category: 'Lanches',
      avaliation: 4.8,
      description: 'Hambúrguer artesanal com dois discos de carne bovina',
    ),
    Product(
      id: 3,
      name: 'Porção de frango 400g',
      restaurant: 'Tipteams',
      imageUrl: 'assets/images/porco_eats_images/products/porcaofrango400g.png',
      price: 44.90,
      category: 'Porções',
      avaliation: 4.9,
      description: 'Porção generosa de frango com base de batata frita',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/cart');
        },
        backgroundColor: Colors.orange,
        child: const Text('V er carrinho'),
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
    backgroundColor: Colors.transparent,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      builder: (context, scrollController) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset(
                  product.imageUrl,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
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
                  style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
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
                        final quantity = controller.getQuantity(product);

                        return Row(
                          children: [
                            if (quantity > 0)
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.orange.shade50,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        controller.decreaseQuantity(product);
                                      },
                                      icon: const Icon(Icons.remove, size: 18),
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
                                        controller.increaseQuantity(product);
                                      },
                                      icon: const Icon(Icons.add, size: 18),
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
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '${product.name} adicionado ao carrinho!',
                                        style: GoogleFonts.poppins(),
                                      ),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.shopping_cart),
                                label: const Text('Adicionar'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 12,
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
