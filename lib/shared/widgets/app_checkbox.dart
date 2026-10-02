import 'package:flutter/material.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';

class AppCheckBox extends StatelessWidget {
  const AppCheckBox({super.key, required this.value, this.onChanged});

  final bool value;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: onChanged,
      side: BorderSide(color: AppColors.yellowAgility, width: 2),
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.yellowAgility;
        }

        return Colors.transparent;
      }),

      checkColor: Colors.white,
    );
  }
}
