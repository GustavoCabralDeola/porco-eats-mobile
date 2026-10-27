import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:porco_eats/features/home/controllers/home_controller.dart';
import 'package:porco_eats/features/login/controllers/login_controller.dart';
import 'package:porco_eats/models/enums/user_role.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:porco_eats/shared/widgets/navigation/app_home_navigation_bar_customer.dart';
import 'package:porco_eats/shared/widgets/app_product_bottom_sheet.dart';
import 'package:porco_eats/shared/widgets/app_product_card.dart';
import 'package:porco_eats/shared/widgets/app_search_field.dart';
import 'package:porco_eats/shared/widgets/navigation/app_home_navigation_bar_manager.dart';
import 'package:provider/provider.dart';

class CategoryProductsPage extends StatefulWidget {
  static const route = '/category-products';

  const CategoryProductsPage({super.key, required this.categoryName});

  final String categoryName;

  @override
  State<CategoryProductsPage> createState() => _CategoryProductsPageState();
}

class _CategoryProductsPageState extends State<CategoryProductsPage> {
  final _searchController = TextEditingController();
  String _searchText = '';
  String? _sortOption;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _showSortDialog() async {
    final option = await showDialog<String>(
      context: context,
      builder: (_) => _CategorySortDialog(selectedOption: _sortOption),
    );
    if (option != null) setState(() => _sortOption = option);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brownWhite,
      appBar: AppBar(
        backgroundColor: AppColors.brownWhite,
        foregroundColor: AppColors.darkBrown,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(widget.categoryName),
      ),
      bottomNavigationBar: Consumer<LoginController>(
        builder: (context, controller, child) {
          return controller.user?.role == UserRole.customer
              ? const AppHomeNavigationBarCustomer()
              : const AppHomeNavigationBarManager();
        },
      ),
      body: Consumer<HomeController>(
        builder: (context, controller, child) {
          final query = _searchText.trim().toLowerCase();
          final products = controller.productsInCategory(widget.categoryName)
              .where((product) =>
                  query.isEmpty ||
                  product.name.toLowerCase().contains(query) ||
                  product.restaurant.toLowerCase().contains(query))
              .toList();

          switch (_sortOption) {
            case 'Mais bem avaliado':
              products.sort((a, b) => b.avaliation.compareTo(a.avaliation));
              break;
            case 'Mais barato':
              products.sort((a, b) => a.price.compareTo(b.price));
              break;
            case 'Mais caro':
              products.sort((a, b) => b.price.compareTo(a.price));
              break;
          }

          return Column(
            children: [
              const SizedBox(height: 10),
              AppSearchField(
                hintText: 'O que você deseja comer hoje?',
                enableFilter: true,
                controller: _searchController,
                onChanged: (value) => setState(() => _searchText = value),
                onFilterPressed: _showSortDialog,
              ),
              Expanded(
                child: products.isEmpty
                    ? Center(
                        child: Text(
                          'Nenhum produto encontrado.',
                          style: GoogleFonts.poppins(color: AppColors.subTitle),
                        ),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 180,
                          mainAxisExtent: 190,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return AppProductCard(
                            product: product,
                            onTap: () =>
                                showProductBottomSheet(context, product),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CategorySortDialog extends StatefulWidget {
  const _CategorySortDialog({required this.selectedOption});

  final String? selectedOption;

  @override
  State<_CategorySortDialog> createState() => _CategorySortDialogState();
}

class _CategorySortDialogState extends State<_CategorySortDialog> {
  static const _options = [
    'Mais bem avaliado',
    'Mais barato',
    'Mais caro',
  ];
  late String? _selected = widget.selectedOption;

  @override
  Widget build(BuildContext context) {
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
                const Icon(Icons.filter_alt_outlined,
                    color: AppColors.yellowAgility, size: 19),
                const SizedBox(width: 8),
                Expanded(
                  child: Text('Ordenar produtos',
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(20),
                  child: const CircleAvatar(
                    radius: 14,
                    backgroundColor: Color(0xFF51351F),
                    child: Icon(Icons.close,
                        size: 16, color: AppColors.yellowAgility),
                  ),
                ),
              ]),
            ),
            Container(
              width: double.infinity,
              color: const Color(0xFFFAF9F6),
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
              child: Text('Selecione como deseja ordenar os produtos.',
                  style: GoogleFonts.poppins(
                      fontSize: 10, color: AppColors.title)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                children: _options.map((option) {
                  final selected = _selected == option;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: InkWell(
                      onTap: () => setState(() => _selected = option),
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        height: 52,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: selected
                              ? const Color(0xFFFFFAF0)
                              : Colors.white,
                          border: Border.all(
                              color: selected
                                  ? const Color(0xFFF2C875)
                                  : const Color(0xFFF2F1EE)),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: selected
                                ? AppColors.yellowAgility
                                : const Color(0xFFF5F4F1),
                            child: Icon(
                              option == 'Mais bem avaliado'
                                  ? Icons.star_outline
                                  : option == 'Mais barato'
                                      ? Icons.arrow_upward
                                      : Icons.arrow_downward,
                              size: 18,
                              color: selected
                                  ? AppColors.darkBrown
                                  : AppColors.greyshade,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(option,
                                style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.title)),
                          ),
                          Radio<String>(
                            value: option,
                            groupValue: _selected,
                            onChanged: (value) =>
                                setState(() => _selected = value),
                            activeColor: AppColors.yellowAgility,
                          ),
                        ]),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 6),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, _selected),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.yellowAgility,
                    foregroundColor: AppColors.darkBrown,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28)),
                  ),
                  child: Text('Aplicar Filtros',
                      style: GoogleFonts.poppins(
                          fontSize: 13, fontWeight: FontWeight.w600)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12, top: 2),
              child: Text.rich(TextSpan(
                  style: GoogleFonts.poppins(
                      fontSize: 10, color: AppColors.subTitle),
                  children: const [
                    TextSpan(text: 'Alimentado por '),
                    TextSpan(
                        text: 'Porco Eats',
                        style: TextStyle(
                            color: AppColors.redDelivery,
                            fontWeight: FontWeight.w600)),
                  ])),
            ),
          ],
        ),
      ),
    );
  }
}
