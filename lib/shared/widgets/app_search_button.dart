import 'package:flutter/material.dart';
import 'package:porco_eats/features/home/controllers/home_filter_controller.dart';
import 'package:porco_eats/features/home/controllers/home_controller.dart';
import 'package:porco_eats/features/home/widgets/home_filter_dialog.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:provider/provider.dart';

class AppSearchButton extends StatelessWidget {
  const AppSearchButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
          return;
        }
        final home = context.read<HomeController>();
        showDialog<Set<String>>(
          context: context,
          builder: (dialogContext) => ChangeNotifierProvider(
            create: (_) => HomeFilterController(
              initialCategories: home.selectedCategories,
            ),
            child: const HomeFilterDialog(),
          ),
        ).then((categories) {
          if (categories != null) home.applyCategoryFilters(categories);
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.darkBrown,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(Icons.tune, color: AppColors.yellowAgility, size: 30),
      ),
    );
  }
}
