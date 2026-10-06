import 'package:flutter/material.dart';
import 'package:porco_eats/features/home/controllers/catalog_filter_controller.dart';
import 'package:porco_eats/features/home/controllers/home_controller.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:provider/provider.dart';

class CatalogFilterDialog extends StatelessWidget {
  const CatalogFilterDialog({super.key, required this.onApply});

  final ValueChanged<Set<String>> onApply;

  static Future<void> show({
    required BuildContext context,
    required Set<String> selectedCategories,
    required ValueChanged<Set<String>> onApply,
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) => ChangeNotifierProvider(
        create: (_) => CatalogFilterController(selectedCategories),
        child: CatalogFilterDialog(onApply: onApply),
      ),
    );
  }

  void _applyFilters(BuildContext context) {
    onApply(context.read<CatalogFilterController>().selectedCategories);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final categoriesInDialog = context
        .watch<CatalogFilterController>()
        .selectedCategories;
    final dialogHeight = MediaQuery.sizeOf(context).height * 0.82;

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      backgroundColor: AppColors.fullWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: 420,
        height: dialogHeight,
        child: Column(
          children: [
            _buildHeader(context),
            _buildInstructions(context, categoriesInDialog),
            Expanded(child: _buildCategoryList(context, categoriesInDialog)),
            _buildApplyButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: AppColors.darkBrown,
      padding: const EdgeInsets.fromLTRB(20, 8, 12, 8),
      child: Row(
        children: [
          const Icon(Icons.filter_list, color: AppColors.yellowAgility),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Filtrar por categoria',
              style: TextStyle(
                color: AppColors.fullWhite,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          IconButton(
            tooltip: 'Fechar filtros',
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, color: AppColors.yellowAgility),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructions(
    BuildContext context,
    Set<String> categoriesInDialog,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 16, 10),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Escolha uma ou mais categorias para encontrar seus favoritos.',
              style: TextStyle(color: AppColors.subTitle, fontSize: 13),
            ),
          ),
          TextButton(
            onPressed: categoriesInDialog.isEmpty
                ? null
                : context.read<CatalogFilterController>().clearCategories,
            child: Text('Limpar (${categoriesInDialog.length})'),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryList(
    BuildContext context,
    Set<String> categoriesInDialog,
  ) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      itemCount: HomeController.availableCategories.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final category = HomeController.availableCategories[index];
        final isSelected = categoriesInDialog.contains(category);

        return _CategoryOptionTile(
          name: category,
          icon: _categoryIcon(category),
          selected: isSelected,
          onTap: () =>
              context.read<CatalogFilterController>().toggleCategory(category),
        );
      },
    );
  }

  Widget _buildApplyButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () => _applyFilters(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.yellowAgility,
            foregroundColor: AppColors.darkBrown,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
          child: const Text(
            'Aplicar filtros',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  IconData _categoryIcon(String category) {
    return switch (category) {
      'Lanches' => Icons.lunch_dining,
      'Pizzas' => Icons.local_pizza,
      'Sushi' => Icons.set_meal,
      'Executivos' => Icons.restaurant,
      'Porções' => Icons.tapas,
      'Bebidas' => Icons.local_drink,
      _ => Icons.restaurant_menu,
    };
  }
}

class _CategoryOptionTile extends StatelessWidget {
  const _CategoryOptionTile({
    required this.name,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String name;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = selected
        ? AppColors.categoryBackground
        : AppColors.fullWhite;

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          constraints: const BoxConstraints(minHeight: 54),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected
                  ? AppColors.yellowAgility
                  : AppColors.borderInputColor,
            ),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 17,
                backgroundColor: selected
                    ? AppColors.yellowAgility
                    : AppColors.brownWhite,
                child: Icon(icon, size: 18, color: AppColors.darkBrown),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    color: AppColors.darkBrown,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Checkbox(
                value: selected,
                onChanged: (_) => onTap(),
                activeColor: AppColors.yellowAgility,
                checkColor: AppColors.darkBrown,
                side: const BorderSide(color: AppColors.borderInputColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
