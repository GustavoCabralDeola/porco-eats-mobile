import 'package:flutter/material.dart';
import 'package:porco_eats/features/order_list/controllers/orders_list_controller.dart';
import 'package:porco_eats/models/enums/order_status.dart';
import 'package:porco_eats/shared/widgets/filters/app_order_filter_button.dart';

class AppOrderFilters extends StatelessWidget {
  const AppOrderFilters({
    super.key,
    required this.hasFilters,
    required this.controller,
    required this.onClientFilter,
    required this.onStatusFilter,
    required this.onAdvancedFilter,
  });

  final bool hasFilters;
  final OrderListController controller;

  final VoidCallback onClientFilter;
  final VoidCallback onStatusFilter;
  final VoidCallback onAdvancedFilter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 12, 12),
      child: Row(
        children: [
          AppOrderFilterButton(
            label: 'Todos',
            selected: !hasFilters,
            onTap: controller.clearFilters,
          ),

          SizedBox(width: 8),

          AppOrderFilterButton(
            label: controller.selectedCustomer ?? 'Cliente',
            selected: controller.selectedCustomer != null,
            icon: Icons.keyboard_arrow_down,
            onTap: onClientFilter,
          ),

          SizedBox(width: 8),

          AppOrderFilterButton(
            label: controller.selectedStatus?.label ?? 'Status',
            selected: controller.selectedStatus != null,
            icon: Icons.keyboard_arrow_down,
            onTap: onStatusFilter,
          ),

          Spacer(),

          Material(
            color: Color(0xFFEDEBE8),
            shape: CircleBorder(),
            child: IconButton(
              tooltip: 'Abrir filtros',
              onPressed: onAdvancedFilter,
              icon: Icon(Icons.filter_list, size: 19),
            ),
          ),
        ],
      ),
    );
  }
}
