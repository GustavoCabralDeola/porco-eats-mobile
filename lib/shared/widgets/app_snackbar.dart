import 'package:custom_snackbar_plus/custom_snackbar_plus.dart';
import 'package:flutter/material.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';

class AppSnackbar {
  static void showSuccess({
    required BuildContext context,
    required String title,
    required String label,
    Duration duration = const Duration(seconds: 3),
  }) {
    CustomSnackbar.show(
      context: context,
      title: title,
      label: label,
      type: SnackbarType.success,
      color: AppColors.greenDelivered,
      svgColor: Colors.lightGreen,
      duration: duration,
    );
  }
}
