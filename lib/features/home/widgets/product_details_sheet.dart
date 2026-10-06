import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:porco_eats/features/cart/controllers/cart_controller.dart';
import 'package:porco_eats/models/product.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:porco_eats/shared/widgets/app_quantity_control.dart';
import 'package:provider/provider.dart';

class ProductDetailsSheet extends StatelessWidget {
  const ProductDetailsSheet({super.key, required this.product});

  final Product product;

  static Future<void> show(BuildContext context, Product product) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.fullWhite,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => ProductDetailsSheet(product: product),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.borderInputColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: AspectRatio(
                aspectRatio: 1.5,
                child: Image.asset(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: AppColors.categoryBackground,
                    child: const Icon(
                      Icons.restaurant,
                      color: AppColors.darkBrown,
                      size: 48,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              product.name,
              style: GoogleFonts.poppins(
                color: AppColors.darkBrown,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              product.restaurant,
              style: const TextStyle(color: AppColors.subTitle),
            ),
            const SizedBox(height: 12),
            Text(
              product.description ?? 'Um produto delicioso esperando por você.',
              style: const TextStyle(color: AppColors.title, height: 1.4),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'R\$ ${product.price.toStringAsFixed(2).replaceAll('.', ',')}',
                  style: GoogleFonts.poppins(
                    color: AppColors.darkBrown,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Consumer<CartController>(
                  builder: (context, cart, child) {
                    final quantity = cart.getQuantity(product);
                    if (quantity > 0) {
                      return AppQuantityControl(
                        quantity: quantity,
                        onDecrease: () => cart.decreaseQuantity(product),
                        onIncrease: () => cart.increaseQuantity(product),
                      );
                    }

                    return ElevatedButton.icon(
                      onPressed: () => cart.addToCart(product),
                      icon: const Icon(Icons.shopping_cart_outlined),
                      label: const Text('Adicionar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.yellowAgility,
                        foregroundColor: AppColors.darkBrown,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
