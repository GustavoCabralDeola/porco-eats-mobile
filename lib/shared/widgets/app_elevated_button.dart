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
  const AppElevatedButton({
    super.key,
    this.onPressed,
    required this.label,
    this.labelStyle,
    required this.type,
    this.isLoading = false,
    this.prefixIcon,
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
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(label, style: labelStyle),
                ),
              ],
            ),
    );
  }

  ButtonStyle _getButtonStyle() {
    switch (type) {
      case ButtonType.filled:
        return ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(48),
          foregroundColor: AppColors.fullWhite,
          backgroundColor: AppColors.redDelivery,
        );

      case ButtonType.outlined:
        return ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(48),
          foregroundColor: AppColors.redDelivery,
          backgroundColor: AppColors.fullWhite,
        );
    }
  }
}
