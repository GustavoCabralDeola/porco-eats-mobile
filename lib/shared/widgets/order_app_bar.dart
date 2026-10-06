import 'package:flutter/material.dart';
import 'package:porco_eats/features/order_list/controllers/orders_list_controller.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';

class OrderAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OrderAppBar({super.key, required this.controller});

  final OrderListController controller;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.darkBrown,
      foregroundColor: AppColors.fullWhite,
      elevation: 0,
      title: controller.isSearching
          ? TextField(
              controller: controller.searchController,
              autofocus: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Buscar pedidos...',
                hintStyle: TextStyle(color: Colors.white70),
                border: InputBorder.none,
              ),
            )
          : Text(
              'Pedidos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
      actions: [
        IconButton(
          tooltip: controller.isSearching ? 'Fechar busca' : 'Buscar pedido',
          onPressed: controller.toggleSearch,
          icon: Icon(controller.isSearching ? Icons.close : Icons.search),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
