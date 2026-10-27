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
    this.displayGrid = false,
  });

  final String title;
  final List<Product> products;
  final void Function(Product) onProductTap;

  final List<String?>? badgeLabels;

  final List<Color?>? badgeColors;
  final bool displayGrid;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(title, style: AppTextStyle.sectionTitle),
          ),
          const SizedBox(height: 20),
        ],
        if (displayGrid)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 180,
              mainAxisExtent: 190,
              crossAxisSpacing: 12,
              mainAxisSpacing: 16,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) => _buildProductCard(index),
          )
        else
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 14),
                ...List.generate(
                  products.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 32),
                    child: _buildProductCard(index),
                  ),
                ),
                const SizedBox(width: 14),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildProductCard(int index) {
    final product = products[index];
    final badge = badgeLabels != null && index < badgeLabels!.length
        ? badgeLabels![index]
        : null;
    final color = badgeColors != null && index < badgeColors!.length
        ? badgeColors![index]
        : null;

    return AppProductCard(
      product: product,
      badgeLabel: badge,
      badgeColor: color,
      onTap: () => onProductTap(product),
    );
  }
}
