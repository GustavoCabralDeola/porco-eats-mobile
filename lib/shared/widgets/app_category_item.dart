import 'package:flutter/material.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';

class AppCategoryItem extends StatelessWidget {
  const AppCategoryItem({
    super.key,
    required this.image,
    required this.imageWidth,
    required this.imageHeight,
    this.scale = 1,
    this.onTap,
  });

  final String image;
  final double imageWidth;
  final double imageHeight;
  final double scale;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: CircleBorder(),
      child: Ink(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.darkBrown),
          borderRadius: BorderRadius.circular(30),
          color: AppColors.categoryBackground,
        ),
        child: InkWell(
          onTap: onTap,
          customBorder: CircleBorder(),
          child: Center(
            child: Transform.scale(
              scale: scale,
              child: Image.asset(image, width: imageWidth, height: imageHeight),
            ),
          ),
        ),
      ),
    );
  }
}
