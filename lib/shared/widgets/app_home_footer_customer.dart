import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:porco_eats/features/cart/pages/cart_page.dart';
import 'package:porco_eats/features/home/pages/home_page.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';

class AppHomeFooterCustomer extends StatelessWidget {
  const AppHomeFooterCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.darkBrown,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () => Navigator.pushNamed(context, HomePage.route),
            child: _NavigationBarItem(
              icon: Icons.home_rounded,
              label: 'Início',
              selected: true,
            ),
          ),

          InkWell(
            onTap: () => Navigator.pushNamed(context, CartPage.route),
            child: _NavigationBarItem(
              icon: Icons.list_alt_rounded,
              label: 'Meus pedidos',
            ),
          ),

          InkWell(
            //onTap: () => Navigator.pushNamed(context, ProfilePage.route),
            child: _NavigationBarItem(
              icon: Icons.person_rounded,
              label: 'Perfil',
            ),
          ),
        ],
      ),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  const _NavigationBarItem({
    required this.icon,
    required this.label,
    this.selected = false,
  });

  final IconData icon;
  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final iconWidget = selected
        ? Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.yellowAgility,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: AppColors.darkBrown, size: 24),
          )
        : Icon(icon, color: AppColors.fullWhite, size: 24);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        iconWidget,
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 11,
            color: selected ? AppColors.yellowAgility : AppColors.fullWhite,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
