import 'package:flutter/material.dart';
import 'package:porco_eats/features/home/controllers/home_controller.dart';
import 'package:porco_eats/features/home/pages/category_products_page.dart';
import 'package:porco_eats/shared/widgets/app_category_item.dart';
import 'package:provider/provider.dart';

class AppHomeCategoriesRow extends StatelessWidget {
  const AppHomeCategoriesRow({super.key});

  static const _categories = [
    _CategoryData(
      label: 'Lanches',
      image:
          'assets/images/porco_eats_images/categories_icons/hamburguerIcon.png',
      width: 43,
      height: 43,
    ),
    _CategoryData(
      label: 'Pizzas',
      image: 'assets/images/porco_eats_images/categories_icons/pizzaIcon.png',
      width: 43,
      height: 43,
    ),
    _CategoryData(
      label: 'Sushi',
      image: 'assets/images/porco_eats_images/categories_icons/sushiIcon.png',
      width: 50,
      height: 50,
    ),
    _CategoryData(
      label: 'Executivos',
      image:
          'assets/images/porco_eats_images/categories_icons/executivoIcon.png',
      width: 100,
      height: 55,
      scale: 1.5,
    ),
    _CategoryData(
      label: 'Porções',
      image: 'assets/images/porco_eats_images/categories_icons/porcoesIcon.png',
      width: 74,
      height: 58,
    ),
    _CategoryData(
      label: 'Bebidas',
      image: 'assets/images/porco_eats_images/categories_icons/bebidaIcon.png',
      width: 60,
      height: 80,
    ),
  ];

  void _openCategory(BuildContext context, String categoryName) {
    Navigator.of(
      context,
    ).pushNamed(CategoryProductsPage.route, arguments: categoryName);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SizedBox(width: 20),
          ..._categories.map(
            (cat) => Padding(
              padding: const EdgeInsets.only(right: 10),
              child: AppCategoryItem(
                label: cat.label,
                image: cat.image,
                imageWidth: cat.width,
                imageHeight: cat.height,
                scale: cat.scale,
                onTap: () => _openCategory(context, cat.label),
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}

class _CategoryData {
  final String label;
  final String image;
  final double width;
  final double height;
  final double scale;

  const _CategoryData({
    required this.label,
    required this.image,
    required this.width,
    required this.height,
    this.scale = 1,
  });
}
