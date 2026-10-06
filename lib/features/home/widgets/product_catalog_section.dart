import 'package:flutter/material.dart';
import 'package:porco_eats/models/product.dart';
import 'package:porco_eats/shared/widgets/app_product_card.dart';
import 'package:porco_eats/shared/widgets/app_text_style.dart';

class ProductCatalogSection extends StatelessWidget {
  const ProductCatalogSection({
    super.key,
    required this.title,
    required this.products,
    required this.onProductTap,
    this.showGrid = false,
  });

  final String title;
  final List<Product> products;
  final ValueChanged<Product> onProductTap;
  final bool showGrid;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          children: [
            Text(title, style: AppTextStyle.sectionTitle),
            const SizedBox(height: 16),
            const Text('Não encontramos produtos com esses filtros.'),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(title, style: AppTextStyle.sectionTitle),
        ),
        const SizedBox(height: 20),
        if (showGrid)
          GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              mainAxisExtent: AppProductCard.cardHeight,
            ),
            itemBuilder: (context, index) {
              final product = products[index];
              return Center(
                child: AppProductCard(
                  product: product,
                  width: AppProductCard.cardWidth,
                  height: AppProductCard.cardHeight,
                  onTap: () => onProductTap(product),
                ),
              );
            },
          )
        else
          SizedBox(
            height: 174,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              separatorBuilder: (context, index) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                final product = products[index];
                return AppProductCard(
                  product: product,
                  onTap: () => onProductTap(product),
                );
              },
            ),
          ),
      ],
    );
  }
}
