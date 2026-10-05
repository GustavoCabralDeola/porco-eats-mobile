import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:porco_eats/features/cart/controllers/cart_controller.dart';
import 'package:porco_eats/models/product.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:provider/provider.dart';

import '../app_quantity_button.dart';

class AppCartItemCard extends StatelessWidget {
  final Product product;
  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const AppCartItemCard({
    required this.product,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    final cartController = context.watch<CartController>();

    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.fullWhite,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderInputColor),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  product.imageUrl,
                  width: 82,
                  height: 82,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.darkBrown,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      product.restaurant,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppColors.subTitle,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'R\$ ${product.price.toStringAsFixed(2)}',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.darkBrown,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.subTitle,
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              SizedBox(
                width: 110,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppQuantityButton(
                      icon: Icons.remove,
                      onPressed: () => onDecrease(),
                    ),
                    Text(
                      quantity.toString(),
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkBrown,
                      ),
                    ),
                    AppQuantityButton(icon: Icons.add, onPressed: onIncrease),
                  ],
                ),
              ),
              Spacer(),
              Text(
                'R\$ ${(product.price * quantity).toStringAsFixed(2)}',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.darkBrown,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          TextFormField(
            initialValue: product.observation ?? '',
            onChanged: (value) =>
                cartController.updateObservation(product, value),
            minLines: 1,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Observações',
              hintStyle: GoogleFonts.poppins(
                fontSize: 13,
                color: AppColors.subTitle,
              ),
              filled: true,
              fillColor: AppColors.brownWhite,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.redDelivery, width: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
