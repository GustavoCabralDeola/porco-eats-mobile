import 'package:flutter/material.dart';
import 'package:porco_eats/models/product.dart';
import 'package:porco_eats/shared/widgets/app_product_card.dart';
import 'package:porco_eats/shared/widgets/app_text_style.dart';

class AppHomeProductsSection extends StatelessWidget {
  const AppHomeProductsSection({
    super.key,
    required this.title,
    required this.products,
    required this.onProductTap,
    this.badgeLabels,
    this.badgeColors,
  });

  final String title;
  final List<Product> products;
  final void Function(Product) onProductTap;

  final List<String?>? badgeLabels;

  final List<Color?>? badgeColors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(title, style: AppTextStyle.sectionTitle),
        ),
        const SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              const SizedBox(width: 14),
              ...List.generate(products.length, (index) {
                final product = products[index];
                final badge = badgeLabels != null && index < badgeLabels!.length
                    ? badgeLabels![index]
                    : null;
                final color = badgeColors != null && index < badgeColors!.length
                    ? badgeColors![index]
                    : null;

                return Padding(
                  padding: const EdgeInsets.only(right: 32),
                  child: AppProductCard(
                    product: product,
                    badgeLabel: badge,
                    badgeColor: color,
                    onTap: () => onProductTap(product),
                  ),
                );
              }),
              const SizedBox(width: 14),
            ],
          ),
        ),
      ],
    );
  }
}
