import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';

class AppCategoryItem extends StatelessWidget {
  const AppCategoryItem({
    super.key,
    required this.label,
    required this.image,
    required this.imageWidth,
    required this.imageHeight,
    this.scale = 1,
    this.onTap,
    this.selected = false,
  });

  final String label;
  final String image;
  final double imageWidth;
  final double imageHeight;
  final double scale;
  final VoidCallback? onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Material(
          color: Colors.transparent,
          shape: CircleBorder(),
          child: Ink(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(
                color: selected ? AppColors.yellowAgility : AppColors.darkBrown,
                width: selected ? 3 : 1,
              ),
              borderRadius: BorderRadius.circular(30),
              color: AppColors.categoryBackground,
            ),
            child: InkWell(
              onTap: onTap,
              customBorder: CircleBorder(),
              child: Center(
                child: Transform.scale(
                  scale: scale,
                  child: Image.asset(
                    image,
                    width: imageWidth,
                    height: imageHeight,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 3),
        SizedBox(
          width: 60,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              maxLines: 1,
              style: GoogleFonts.poppins(fontSize: 10, height: 1.2),
            ),
          ),
        ),
      ],
    );
  }
}
