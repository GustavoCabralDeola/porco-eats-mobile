import 'package:flutter/material.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';

class AppQuantityControl extends StatelessWidget {
  const AppQuantityControl({
    super.key,
    required this.quantity,
    required this.onDecrease,
    required this.onIncrease,
  });

  final int quantity;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onDecrease,
          icon: const Icon(Icons.remove_circle_outline),
          color: AppColors.darkBrown,
        ),
        Text(
          '$quantity',
          style: const TextStyle(
            color: AppColors.darkBrown,
            fontWeight: FontWeight.w700,
          ),
        ),
        IconButton(
          onPressed: onIncrease,
          icon: const Icon(Icons.add_circle_outline),
          color: AppColors.darkBrown,
        ),
      ],
    );
  }
}
