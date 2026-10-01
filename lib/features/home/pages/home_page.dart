import 'package:flutter/material.dart';
import 'package:porco_eats/features/home/controllers/home_controller.dart';
import 'package:porco_eats/shared/widgets/app_promo_carousel.dart';
import 'package:porco_eats/shared/widgets/app_search_field.dart';
import 'package:porco_eats/shared/widgets/app_text_style.dart';
import 'package:provider/provider.dart';

import '../../../shared/widgets/app_category_item.dart';
import '../../../shared/widgets/app_home_header.dart';

class HomePage extends StatelessWidget {
  static String route = '/home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 20),
                  Container(
                    child: Text(
                      'Ofertas para você',
                      style: AppTextStyle.sectionTitle,
                    ),
                  ),
                ],
              ),
              Material(
                color: Colors.transparent,
                shape: CircleBorder(),
                child: Ink(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.darkBrown),
                    borderRadius: BorderRadius.circular(30),
                    color: AppColors.categoryBackground,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
