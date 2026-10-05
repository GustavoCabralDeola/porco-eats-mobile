import 'package:flutter/material.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';

enum ButtonType { filled, outlined }

class AppElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  final TextStyle? labelStyle;

  final ButtonType type;
  final bool isLoading;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final double suffixIconSize;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final double height;

  const AppElevatedButton({
    super.key,
    this.onPressed,
    required this.label,
    this.labelStyle,
    required this.type,
    this.isLoading = false,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixIconSize = 24,
    this.backgroundColor,
    this.borderRadius,
    this.height = 48,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: _getButtonStyle(),
      child: isLoading
          ? Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(color: AppColors.fullWhite),
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (prefixIcon != null) Icon(prefixIcon),
                if (prefixIcon != null) SizedBox(width: 5),
                Padding(
                  padding: EdgeInsets.only(right: suffixIcon == null ? 10 : 0),
                  child: Text(label, style: labelStyle),
                ),
                if (suffixIcon != null) SizedBox(width: 8),
                if (suffixIcon != null) Icon(suffixIcon, size: suffixIconSize),
              ],
            ),
    );
  }

  ButtonStyle _getButtonStyle() {
    switch (type) {
      case ButtonType.filled:
        return ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(height),
          foregroundColor: AppColors.fullWhite,
          backgroundColor: backgroundColor ?? AppColors.redDelivery,
          shape: borderRadius == null
              ? null
              : RoundedRectangleBorder(borderRadius: borderRadius!),
        );

      case ButtonType.outlined:
        return ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(height),
          foregroundColor: AppColors.redDelivery,
          backgroundColor: AppColors.fullWhite,
          shape: borderRadius == null
              ? null
              : RoundedRectangleBorder(borderRadius: borderRadius!),
        );
    }
  }
}
