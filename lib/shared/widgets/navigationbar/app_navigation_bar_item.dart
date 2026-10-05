import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';

class AppNavigationBarItem extends StatelessWidget {
  const AppNavigationBarItem({
    super.key,
    required this.icon,
    required this.label,
    this.selected = false,
    this.badgeCount = 0,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final int badgeCount;
  final VoidCallback onTap;

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
    final decoratedIcon = badgeCount > 0
        ? Stack(
            clipBehavior: Clip.none,
            children: [
              iconWidget,
              Positioned(
                top: -7,
                right: -9,
                child: Container(
                  constraints: const BoxConstraints(
                    minWidth: 17,
                    minHeight: 17,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: const BoxDecoration(
                    color: AppColors.redDelivery,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    badgeCount > 99 ? '99+' : '$badgeCount',
                    style: const TextStyle(
                      color: AppColors.fullWhite,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          )
        : iconWidget;

    return InkWell(
      onTap: () {
        onTap();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          decoratedIcon,
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
    );
  }
}
