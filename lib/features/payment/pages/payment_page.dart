import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:porco_eats/features/cart/controllers/cart_controller.dart';
import 'package:porco_eats/features/login/controllers/login_controller.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  static String route = '/payment';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brownWhite,
      appBar: AppBar(
        backgroundColor: AppColors.brownWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.darkBrown,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Endereço e pagamento',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.darkBrown,
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    _SectionHeader(
                      icon: Icons.location_on_outlined,
                      title: 'Endereço de entrega',
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.fullWhite,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.borderInputColor),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on_outlined,
                            color: AppColors.darkBrown,
                            size: 22,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Rua das Flores, 123',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.darkBrown,
                              ),
                            ),
                          ),
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: AppColors.darkBrown,
                                width: 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.fullWhite,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.borderInputColor),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.add,
                            color: AppColors.darkBrown,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Adicionar novo endereço',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.darkBrown,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    _SectionHeader(
                      icon: Icons.credit_card_rounded,
                      title: 'Forma de pagamento',
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.fullWhite,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.borderInputColor),
                      ),
                      child: Column(
                        children: [
                          _PaymentOption(
                            title: 'Pix',
                            subtitle: 'Pagamento imediato',
                            selected: true,
                            icon: Icons.pix_rounded,
                            iconColor: AppColors.yellowAgility,
                          ),
                          const Divider(height: 1),
                          _PaymentOption(
                            title: 'Cartão de crédito',
                            subtitle: 'Até 12x',
                            selected: false,
                            icon: Icons.credit_card_rounded,
                          ),
                          const Divider(height: 1),
                          _PaymentOption(
                            title: 'Cartão de débito',
                            subtitle: 'À vista',
                            selected: false,
                            icon: Icons.card_membership_rounded,
                          ),
                          const Divider(height: 1),
                          _PaymentOption(
                            title: 'Dinheiro',
                            subtitle: 'À vista',
                            selected: false,
                            icon: Icons.attach_money_rounded,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.brownWhite,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total do pedido',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkBrown,
                      ),
                    ),
                    Text(
                      'R\$ 51,30',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.darkBrown,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Consumer<LoginController>(
                builder: (context,loginController,child) {
                  return Consumer<CartController>(
                    builder: (context,controller,child) {
                      return SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                      controller.checkout(loginController.user!);
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
                                'Finalizar pedido',
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
                    }
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;

  const _SectionHeader({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.darkBrown, size: 20),
        const SizedBox(width: 10),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.darkBrown,
          ),
        ),
      ],
    );
  }
}

class _PaymentOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool selected;
  final IconData icon;
  final Color? iconColor;

  const _PaymentOption({
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selected ? AppColors.yellowAgility : AppColors.fullWhite,
              border: Border.all(
                color: selected ? AppColors.yellowAgility : AppColors.subTitle,
                width: 2,
              ),
            ),
            child: selected
                ? const Icon(
                    Icons.check,
                    size: 14,
                    color: AppColors.fullWhite,
                  )
                : null,
          ),
          const SizedBox(width: 14),
          Icon(
            icon,
            color: iconColor ?? AppColors.darkBrown,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.darkBrown,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.subTitle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
