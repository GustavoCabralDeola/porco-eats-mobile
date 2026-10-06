import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:porco_eats/features/cart/controllers/cart_controller.dart';
import 'package:porco_eats/features/login/controllers/login_controller.dart';
import 'package:porco_eats/features/payment/pages/payment_page.dart';
import 'package:porco_eats/models/product.dart';
import 'package:porco_eats/shared/widgets/cards/app_cart_item_card.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  static String route = '/cart';

  @override
  Widget build(BuildContext context) {
    final cartController = context.watch<CartController>();
    final uniqueProducts = cartController.uniqueProductsInCart;

    return Scaffold(
      backgroundColor: AppColors.brownWhite,
      appBar: AppBar(
        backgroundColor: AppColors.darkBrown,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.fullWhite,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Carrinho',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.fullWhite,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                children: [
                  for (final product in uniqueProducts)
                    AppCartItemCard(
                      product: product,
                      quantity: cartController.getQuantity(product),
                      onIncrease: () =>
                          cartController.increaseQuantity(product),
                      onDecrease: () =>
                          cartController.decreaseQuantity(product),
                    ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              color: AppColors.brownWhite,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total do pedido',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkBrown,
                        ),
                      ),
                      Text(
                        'R\$ ${cartController.totalPrice.toStringAsFixed(2)}',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.darkBrown,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Consumer<LoginController>(
                    builder: (context, loginController, child) {
                      return SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const PaymentPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.redDelivery,
                            foregroundColor: AppColors.fullWhite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Continuar para o pagamento',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.arrow_forward_rounded, size: 22),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
