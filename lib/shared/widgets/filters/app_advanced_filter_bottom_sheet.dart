import 'package:flutter/material.dart';
import 'package:porco_eats/features/order_list/controllers/orders_list_controller.dart';
import 'package:porco_eats/shared/widgets/app_text_form_field.dart';

class AppAdvancedFilterBottomSheet extends StatelessWidget {
  const AppAdvancedFilterBottomSheet({super.key, required this.controller});

  final OrderListController controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          24,
          24,
          24,
          MediaQuery.viewInsetsOf(context).bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Filtrar pedidos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            AppTextFormField(
              TextInputType.text,
              textEditingcontroller: controller.searchController,
              hintText: 'ID do pedido ou nome do cliente',
              prefixIcon: Icons.search,
              autofocus: true,
              suffixIcon: controller.searchController.text.isEmpty
                  ? null
                  : Icons.close,
              onSuffixIconPressed: controller.clearSearch,
            ),

            const SizedBox(height: 16),

            Align(
              alignment: Alignment.centerRight,
              child: FilledButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Aplicar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
