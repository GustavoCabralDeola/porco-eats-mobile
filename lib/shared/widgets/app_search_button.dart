import 'package:flutter/material.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';

class AppSearchButton extends StatelessWidget {
  const AppSearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 49,
      height: 47,
      child: ElevatedButton(
        onPressed: () {
          // Abrir dialog do filtro
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: AppColors.darkBrown,
          foregroundColor: AppColors.yellowAgility,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Icon(Icons.tune, size: 28, color: AppColors.yellowAgility),
      ),
    );
  }
}
