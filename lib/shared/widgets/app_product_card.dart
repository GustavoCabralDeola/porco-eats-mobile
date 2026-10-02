import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:porco_eats/models/product.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';

class AppProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final String? badgeLabel;
  final Color? badgeColor;
  final double? discountPercent;

  const AppProductCard({
    required this.product,
    required this.onTap,
    this.badgeLabel,
    this.badgeColor = Colors.red,
    this.discountPercent,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 160,
          height: 174,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: AppColors.brownWhite,
            border: Border.all(color: AppColors.darkBrown, width: 1.5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                    product.imageUrl,
                    width: double.infinity,
                    height: 88,
                    fit: BoxFit.cover,
                  ),
                  if (badgeLabel != null)
                    Positioned(
                      top: 5,
                      left: 5,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: badgeColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          badgeLabel!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 5, 6, 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      product.restaurant,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 14),
                        const SizedBox(width: 3),
                        Text(
                          product.avaliation.toString(),
                          style: const TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'R\$ ${product.price.toStringAsFixed(2)}',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.shopping_cart,
                          size: 18,
                          color: Colors.orange,
                        ),
                      ],
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
