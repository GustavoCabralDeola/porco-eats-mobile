import 'package:flutter/material.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';

class AppSearchButton extends StatelessWidget {
  const AppSearchButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.darkBrown,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(Icons.tune, color: AppColors.yellowAgility, size: 30),
      ),
    );
  }
}
