import 'package:flutter/material.dart';
import 'package:porco_eats/features/home/controllers/home_search_filter_controller.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:provider/provider.dart';

class AppSearchButton extends StatelessWidget {
  const AppSearchButton({super.key});

  static const _categoryIcons = <String, String>{
    'Lanches':
        'assets/images/porco_eats_images/categories_icons/hamburguerIcon.png',
    'Pizza': 'assets/images/porco_eats_images/categories_icons/pizzaIcon.png',
    'Sushi': 'assets/images/porco_eats_images/categories_icons/sushiIcon.png',
    'Executivos':
        'assets/images/porco_eats_images/categories_icons/executivoIcon.png',
    'Porções':
        'assets/images/porco_eats_images/categories_icons/porcoesIcon.png',
    'Bebidas':
        'assets/images/porco_eats_images/categories_icons/bebidaIcon.png',
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeSearchFilterController>(
      builder: (context, controller, child) => IconButton(
        tooltip: 'Filtrar por categoria',
        onPressed: () => _showFilters(context, controller),
        style: IconButton.styleFrom(
          backgroundColor: AppColors.darkBrown,
          foregroundColor: AppColors.yellowAgility,
          fixedSize: const Size(60, 60),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        icon: Stack(
          clipBehavior: Clip.none,
          children: [
            const Icon(Icons.tune, size: 30),
            if (controller.activeProductFilterCount > 0)
              Positioned(
                right: -7,
                top: -7,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: AppColors.redDelivery,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _showFilters(
    BuildContext context,
    HomeSearchFilterController controller,
  ) async {
    final selected = Set<String>.of(controller.selectedCategories);

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        final screenHeight = MediaQuery.sizeOf(dialogContext).height;
        return StatefulBuilder(
          builder: (context, setDialogState) => Dialog(
            backgroundColor: AppColors.fullWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            insetPadding: const EdgeInsets.symmetric(horizontal: 20),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 380,
                maxHeight: screenHeight * 0.9,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHeader(dialogContext),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(18, 12, 14, 12),
                    color: const Color(0xFFF7F5F1),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Selecione suas preferências para refinar as ofertas.',
                            style: TextStyle(
                              color: AppColors.darkBrown,
                              fontSize: 11,
                              height: 1.4,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () =>
                              setDialogState(() => selected.clear()),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.redDelivery,
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: Text(
                            'Limpar (${selected.length})',
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                      children: [
                        for (final category
                            in controller.availableProductCategories)
                          _buildCategoryTile(
                            category,
                            selected.contains(category),
                            () => setDialogState(() {
                              if (!selected.remove(category)) {
                                selected.add(category);
                              }
                            }),
                          ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
                    decoration: const BoxDecoration(
                      color: AppColors.fullWhite,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x12000000),
                          offset: Offset(0, -3),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 46,
                          child: FilledButton(
                            onPressed: () {
                              controller.setSelectedCategories(selected);
                              Navigator.pop(dialogContext);
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: AppColors.yellowAgility,
                              foregroundColor: AppColors.darkBrown,
                              elevation: 2,
                              shape: const StadiumBorder(),
                            ),
                            child: const Text(
                              'Aplicar Filtros',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text.rich(
                          TextSpan(
                            style: TextStyle(
                              color: AppColors.subTitle,
                              fontSize: 10,
                            ),
                            children: [
                              TextSpan(text: 'Alimentado por '),
                              TextSpan(
                                text: 'Porco Eats',
                                style: TextStyle(
                                  color: AppColors.redDelivery,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 10, 12, 10),
      decoration: const BoxDecoration(
        color: AppColors.darkBrown,
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.filter_alt_outlined,
            color: AppColors.yellowAgility,
            size: 20,
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Filtrar por categoria',
              style: TextStyle(
                color: AppColors.fullWhite,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            tooltip: 'Fechar',
            onPressed: () => Navigator.pop(context),
            style: IconButton.styleFrom(
              backgroundColor: const Color(0xFF4A2D1D),
              foregroundColor: AppColors.yellowAgility,
              fixedSize: const Size(32, 32),
              padding: EdgeInsets.zero,
            ),
            icon: const Icon(Icons.close, size: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTile(
    String category,
    bool isSelected,
    VoidCallback onTap,
  ) {
    final imagePath = _categoryIcons[category];
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: isSelected ? const Color(0xFFFFFAF1) : AppColors.fullWhite,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 52,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(
                color: isSelected
                    ? AppColors.yellowAgility
                    : const Color(0xFFF0EFEC),
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.yellowAgility
                        : const Color(0xFFF4F3F0),
                    shape: BoxShape.circle,
                  ),
                  child: imagePath == null
                      ? const Icon(Icons.restaurant, size: 18)
                      : Image.asset(
                          imagePath,
                          width: 24,
                          height: 24,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.restaurant, size: 18),
                        ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    category == 'Pizza' ? 'Pizzas' : category,
                    style: const TextStyle(
                      color: AppColors.darkBrown,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.yellowAgility
                        : AppColors.fullWhite,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.yellowAgility
                          : const Color(0xFFD8D7D3),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check,
                          size: 16,
                          color: AppColors.darkBrown,
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
