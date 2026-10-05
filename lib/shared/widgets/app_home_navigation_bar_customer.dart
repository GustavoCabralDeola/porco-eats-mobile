import 'package:flutter/material.dart';
import 'package:porco_eats/features/customer_order/controllers/customer_order_controller.dart';
import 'package:porco_eats/features/customer_order/pages/customer_order_page.dart';
import 'package:porco_eats/features/home/pages/home_page.dart';
import 'package:porco_eats/features/login/controllers/login_controller.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:porco_eats/shared/widgets/navigationbar/app_navigation_bar_item.dart';
import 'package:porco_eats/features/profile/pages/profile_page.dart';
import 'package:provider/provider.dart';

class AppHomeNavigationBarCustomer extends StatelessWidget {
  const AppHomeNavigationBarCustomer({super.key, this.selectedIndex = 0});

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<LoginController>().user;
    final activeOrders = context
        .watch<CustomerOrderController>()
        .activeOrderCountFor(user);
    final routeName = ModalRoute.of(context)?.settings.name;
    final currentIndex = routeName == HomePage.route
        ? 0
        : routeName == CustomerOrderPage.route
        ? 1
        : routeName == ProfilePage.route
        ? 2
        : selectedIndex;

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
            onTap: () => _navigateTo(context, HomePage.route, currentIndex, 0),
            icon: Icons.home_rounded,
            label: 'Início',
            selected: currentIndex == 0,
          ),
          AppNavigationBarItem(
            onTap: () =>
                _navigateTo(context, CustomerOrderPage.route, currentIndex, 1),
            icon: Icons.list_alt_rounded,
            label: 'Meus pedidos',
            selected: currentIndex == 1,
            badgeCount: activeOrders,
          ),
          AppNavigationBarItem(
            onTap: () =>
                _navigateTo(context, ProfilePage.route, currentIndex, 2),
            icon: Icons.person_rounded,
            label: 'Perfil',
            selected: currentIndex == 2,
          ),
        ],
      ),
    );
  }

  void _navigateTo(
    BuildContext context,
    String route,
    int currentIndex,
    int destinationIndex,
  ) {
    if (currentIndex == destinationIndex) return;
    Navigator.of(context).pushReplacementNamed(route);
  }
}
