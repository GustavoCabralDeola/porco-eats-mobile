import 'package:flutter/material.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';

class AppSearchButton extends StatelessWidget {
  const AppSearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        //Abrir dialog do filtro
      },
      child: Container(
        width: 65,
        height: 65,
        decoration: BoxDecoration(
          color: AppColors.darkBrown,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(Icons.tune, color: AppColors.yellowAgility, size: 30),
      ),
    );
  }
}
