import 'package:flutter/material.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';

class AppQuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const AppQuantityButton({required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: onPressed == null
              ? AppColors.borderInputColor
              : AppColors.fullWhite,
          border: Border.all(color: AppColors.borderInputColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18, color: AppColors.darkBrown),
      ),
    );
  }
}
