import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';

class AppTextStyle {
  static final TextStyle title = GoogleFonts.inter(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.title,
  );
  static final TextStyle subTitle = GoogleFonts.inter(
    fontSize: 18,
    color: AppColors.subTitle,
    fontWeight: FontWeight.bold,
  );
}
