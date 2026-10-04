import 'package:flutter/material.dart';
import 'package:porco_eats/features/Dashboard/pages/dashboard_order_page.dart';
import 'package:porco_eats/features/order_list/pages/orders_list_page.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:porco_eats/features/profile/pages/profile_page.dart';

import 'navigationbar/app_navigation_bar_item.dart';

class AppHomeNavigationBarManager extends StatelessWidget {
  const AppHomeNavigationBarManager({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.darkBrown,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AppNavigationBarItem(
            onTap: () {},
            icon: Icons.home_rounded,
            label: 'Início',
            selected: true,
          ),
          AppNavigationBarItem(
            icon: Icons.list_alt_rounded,
            label: 'Pedidos',
            onTap: () => Navigator.pushNamed(context, OrdersPage.route),
          ),
          AppNavigationBarItem(
            icon: Icons.bar_chart_rounded,
            label: 'Dashboard',
            onTap: () => Navigator.pushNamed(context, DashboardOrderPage.route),
          ),
          AppNavigationBarItem(
            icon: Icons.person_rounded,
            label: 'Perfil',
            onTap: () => Navigator.pushNamed(context, ProfilePage.route),
          ),
        ],
      ),
    );
  }
}
