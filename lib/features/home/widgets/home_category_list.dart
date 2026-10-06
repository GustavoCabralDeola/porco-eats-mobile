import 'package:flutter/material.dart';
import 'package:porco_eats/shared/widgets/app_category_item.dart';

class HomeCategoryList extends StatelessWidget {
  const HomeCategoryList({
    super.key,
    required this.selectedCategories,
    required this.onCategoryPressed,
  });

  final Set<String> selectedCategories;
  final ValueChanged<String> onCategoryPressed;

  static const List<_CategoryOption> _categories = [
    _CategoryOption(
      name: 'Lanches',
      image: 'assets/images/porco_eats_images/categories_icons/hamburguerIcon.png',
      imageWidth: 43,
      imageHeight: 43,
    ),
    _CategoryOption(
      name: 'Pizzas',
      image: 'assets/images/porco_eats_images/categories_icons/pizzaIcon.png',
      imageWidth: 43,
      imageHeight: 43,
    ),
    _CategoryOption(
      name: 'Sushi',
      image: 'assets/images/porco_eats_images/categories_icons/sushiIcon.png',
      imageWidth: 50,
      imageHeight: 50,
    ),
    _CategoryOption(
      name: 'Executivos',
      image: 'assets/images/porco_eats_images/categories_icons/executivoIcon.png',
      imageWidth: 100,
      imageHeight: 55,
      scale: 1.5,
    ),
    _CategoryOption(
      name: 'Porções',
      image: 'assets/images/porco_eats_images/categories_icons/porcoesIcon.png',
      imageWidth: 74,
      imageHeight: 58,
    ),
    _CategoryOption(
      name: 'Bebidas',
      image: 'assets/images/porco_eats_images/categories_icons/bebidaIcon.png',
      imageWidth: 60,
      imageHeight: 80,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 78,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final category = _categories[index];
          return AppCategoryItem(
            label: category.name,
            image: category.image,
            imageWidth: category.imageWidth,
            imageHeight: category.imageHeight,
            scale: category.scale,
            selected: selectedCategories.contains(category.name),
            onTap: () => onCategoryPressed(category.name),
          );
        },
      ),
    );
  }
}

class _CategoryOption {
  const _CategoryOption({
    required this.name,
    required this.image,
    required this.imageWidth,
    required this.imageHeight,
    this.scale = 1,
  });

  final String name;
  final String image;
  final double imageWidth;
  final double imageHeight;
  final double scale;
}
