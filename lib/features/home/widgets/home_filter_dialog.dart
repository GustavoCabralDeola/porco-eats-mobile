import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:porco_eats/features/home/controllers/home_filter_controller.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:provider/provider.dart';

class HomeFilterDialog extends StatelessWidget {
  const HomeFilterDialog({super.key});

  static const _icons = <String, IconData>{
    'Lanches': Icons.lunch_dining,
    'Pizzas': Icons.local_pizza,
    'Sushi': Icons.cancel_outlined,
    'Executivos': Icons.cancel_outlined,
    'Porções': Icons.cancel_outlined,
    'Bebidas': Icons.local_drink_outlined,
    'Sobremesas': Icons.cake_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeFilterController>();
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      backgroundColor: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: SizedBox(
        width: 380,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: AppColors.darkBrown,
              padding: const EdgeInsets.fromLTRB(20, 15, 12, 15),
              child: Row(children: [
                const Icon(Icons.filter_alt_outlined, color: AppColors.yellowAgility, size: 19),
                const SizedBox(width: 8),
                Expanded(child: Text('Filtrar por categoria', style: GoogleFonts.poppins(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600))),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(20),
                  child: const CircleAvatar(radius: 14, backgroundColor: Color(0xFF51351F), child: Icon(Icons.close, size: 16, color: AppColors.yellowAgility)),
                ),
              ]),
            ),
            Container(
              color: const Color(0xFFFAF9F6),
              padding: const EdgeInsets.fromLTRB(20, 10, 16, 10),
              child: Row(children: [
                Expanded(child: Text('Selecione suas preferências para refinar as ofertas.', style: GoogleFonts.poppins(fontSize: 10, color: AppColors.title))),
                TextButton(onPressed: controller.clear, child: Text('Limpar (${controller.selectedCount})', style: GoogleFonts.poppins(color: AppColors.redDelivery, fontSize: 11, fontWeight: FontWeight.w600))),
              ]),
            ),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemCount: HomeFilterController.categories.length,
                separatorBuilder: (_, __) => const SizedBox(height: 6),
                itemBuilder: (context, index) {
                  final category = HomeFilterController.categories[index];
                  final selected = controller.isSelected(category);
                  return InkWell(
                    onTap: () => controller.toggleCategory(category),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 52,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: selected ? const Color(0xFFFFFAF0) : Colors.white,
                        border: Border.all(color: selected ? const Color(0xFFF2C875) : const Color(0xFFF2F1EE)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(children: [
                        CircleAvatar(radius: 16, backgroundColor: selected ? AppColors.yellowAgility : const Color(0xFFF5F4F1), child: Icon(_icons[category], size: 18, color: selected ? AppColors.darkBrown : AppColors.greyshade)),
                        const SizedBox(width: 10),
                        Expanded(child: Text(category, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.title))),
                        Checkbox(
                          value: selected,
                          onChanged: (_) => controller.toggleCategory(category),
                          activeColor: AppColors.yellowAgility,
                          checkColor: AppColors.darkBrown,
                          side: const BorderSide(color: Color(0xFFD9D9D5), width: 1.5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        ),
                      ]),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, controller.selectedCategories),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.yellowAgility, foregroundColor: AppColors.darkBrown, elevation: 2, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28))),
                  child: Text('Aplicar Filtros', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.only(bottom: 12, top: 2), child: Text.rich(TextSpan(style: GoogleFonts.poppins(fontSize: 10, color: AppColors.subTitle), children: const [TextSpan(text: 'Alimentado por '), TextSpan(text: 'Porco Eats', style: TextStyle(color: AppColors.redDelivery, fontWeight: FontWeight.w600))]))),
          ],
        ),
      ),
    );
  }
}
