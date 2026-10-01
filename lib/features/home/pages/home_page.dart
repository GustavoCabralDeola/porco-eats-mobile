import 'package:flutter/material.dart';
import 'package:porco_eats/features/home/controllers/home_controller.dart';
import 'package:porco_eats/shared/widgets/app_search_field.dart';
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
                      onTap: () {},
                      image:
                          'assets/images/porco_eats_images/categories_icons/hamburguerIcon.png',
                      imageWidth: 43,
                      imageHeight: 43,
                    ),

                    SizedBox(width: 10),

                    AppCategoryItem(
                      onTap: () {},
                      image:
                          'assets/images/porco_eats_images/categories_icons/pizzaIcon.png',
                      imageWidth: 43,
                      imageHeight: 43,
                    ),

                    SizedBox(width: 10),

                    AppCategoryItem(
                      onTap: () {},
                      image:
                          'assets/images/porco_eats_images/categories_icons/sushiIcon.png',
                      imageWidth: 50,
                      imageHeight: 50,
                    ),

                    SizedBox(width: 10),

                    AppCategoryItem(
                      onTap: () {},
                      image:
                          'assets/images/porco_eats_images/categories_icons/executivoIcon.png',
                      imageWidth: 100,
                      imageHeight: 55,
                      scale: 1.5,
                    ),

                    SizedBox(width: 10),
                    AppCategoryItem(
                      onTap: () {},
                      image:
                          'assets/images/porco_eats_images/categories_icons/porcoesIcon.png',
                      imageWidth: 74,
                      imageHeight: 58,
                    ),

                    SizedBox(width: 10),
                    AppCategoryItem(
                      onTap: () {},
                      image:
                          'assets/images/porco_eats_images/categories_icons/bebidaIcon.png',
                      imageWidth: 60,
                      imageHeight: 80,
                    ),
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
