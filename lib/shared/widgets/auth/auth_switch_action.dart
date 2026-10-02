import 'package:flutter/material.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';

class AuthSwitchAction extends StatelessWidget {
  const AuthSwitchAction({
    super.key,
    required this.leadingText,
    required this.actionText,
    required this.onPressed,
  });

  final String leadingText;
  final String actionText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(leadingText),
        TextButton(
          onPressed: onPressed,
          child: Text(
            actionText,
            style: TextStyle(color: AppColors.redDelivery),
          ),
        ),
      ],
    );
  }
}
