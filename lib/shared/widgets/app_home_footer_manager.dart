import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:porco_eats/features/profile/pages/profile_page.dart';

class AppHomeFooterManager extends StatelessWidget {
  const AppHomeFooterManager({super.key});

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
          _FooterItem(
            icon: Icons.home_rounded,
            label: 'Início',
            selected: true,
          ),
          _FooterItem(icon: Icons.list_alt_rounded, label: 'Pedidos'),
          _FooterItem(icon: Icons.bar_chart_rounded, label: 'Dashboard'),
          _FooterItem(
            icon: Icons.person_rounded,
            label: 'Perfil',
            onTap: () => Navigator.pushNamed(context, ProfilePage.route),
          ),
        ],
      ),
    );
  }
}

class _FooterItem extends StatelessWidget {
  const _FooterItem({
    required this.icon,
    required this.label,
    this.selected = false,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback? onTap;

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

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
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
        ),
      ),
    );
  }
}
