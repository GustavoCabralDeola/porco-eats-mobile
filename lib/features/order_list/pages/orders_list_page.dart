import 'package:flutter/material.dart';
import 'package:porco_eats/features/login/controllers/login_controller.dart';
import 'package:porco_eats/features/order_list/controllers/orders_list_controller.dart';
import 'package:porco_eats/models/enums/user_role.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:porco_eats/shared/widgets/navigation/app_home_navigation_bar_customer.dart';

import 'package:porco_eats/shared/widgets/filters/app_client_filter_bottom_sheet.dart';
import 'package:porco_eats/shared/widgets/navigation/app_home_navigation_bar_manager.dart';
import 'package:provider/provider.dart';

import '../../../shared/widgets/app_order_list.dart';
import '../../../shared/widgets/filters/app_advanced_filter_bottom_sheet.dart';
import '../../../shared/widgets/filters/app_order_filters.dart';
import '../../../shared/widgets/filters/app_status_filter_bottom_sheet.dart';
import '../../../shared/widgets/order_app_bar.dart';

class OrdersPage extends StatelessWidget {
  static String route = '/orders';

  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<OrderListController>();
    final hasFilters = controller.hasFilters;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F6F3),
      bottomNavigationBar: Consumer<LoginController>(
        builder: (context, controller, child) {
          return controller.user?.role == UserRole.customer
              ? const AppHomeNavigationBarCustomer(selectedIndex: 1)
              : const AppHomeNavigationBarManager(selectedIndex: 1);
        },
      ),

      appBar: OrderAppBar(controller: controller),

      body: Column(
        children: [
          AppOrderFilters(
            hasFilters: hasFilters,
            controller: controller,
            onClientFilter: () => _showClientFilter(context, controller),
            onStatusFilter: () => _showStatusFilter(context, controller),
            onAdvancedFilter: () => _showAdvancedFilters(context, controller),
          ),

          Expanded(child: AppOrderList(controller: controller)),
        ],
      ),
    );
  }

  void _showClientFilter(BuildContext context, OrderListController controller) {
    final customers = controller.customers;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return AppClientFilterBottomSheet(controller: controller);
      },
    );
  }

  void _showAdvancedFilters(
    BuildContext context,
    OrderListController controller,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.fullWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return AppAdvancedFilterBottomSheet(controller: controller);
      },
    );
  }

  void _showStatusFilter(BuildContext context, OrderListController controller) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return AppStatusFilterBottomSheet(controller: controller);
      },
    );
  }
}
