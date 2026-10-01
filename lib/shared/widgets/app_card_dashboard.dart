import 'package:flutter/material.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';

class AppCardDashboard extends StatelessWidget {
  const AppCardDashboard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.backgroundColor,
    this.compact = false,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color? backgroundColor;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final double paddingHorizontal = compact ? 8 : 14;
    final double paddingVertical = compact ? 10 : 16;
    final double iconBoxSize = compact ? 34 : 48;
    final double iconSize = compact ? 20 : 28;
    final double titleSize = compact ? 11 : 14;
    final double descriptionSize = compact ? 10 : 12;

    return Card(
      color: backgroundColor ?? AppColors.brownWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: SizedBox(
        width: double.infinity,
        height: compact ? 125 : 150,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: paddingHorizontal,
            vertical: paddingVertical,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: iconBoxSize,
                height: iconBoxSize,
                decoration: const BoxDecoration(
                  color: AppColors.fullWhite,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppColors.darkBrown, size: iconSize),
              ),
              SizedBox(height: compact ? 4 : 6),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.w600,
                  color: AppColors.fullWhite,
                ),
              ),
              SizedBox(height: compact ? 3 : 6),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: descriptionSize,
                  color: AppColors.fullWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
