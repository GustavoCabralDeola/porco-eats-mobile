import 'package:flutter/material.dart';
import 'package:porco_eats/features/home/pages/home_page.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:porco_eats/shared/widgets/navigationbar/app_navigation_bar_item.dart';
import 'package:porco_eats/features/profile/pages/profile_page.dart';

class AppHomeNavigationBarCustomer extends StatelessWidget {
  const AppHomeNavigationBarCustomer({super.key});

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
            onTap: () => Navigator.pushNamed(context, HomePage.route),
            icon: Icons.home_rounded,
            label: 'Início',
            selected: true,
          ),
          AppNavigationBarItem(
            onTap: () {},
            icon: Icons.list_alt_rounded,
            label: 'Meus pedidos',
          ),
          AppNavigationBarItem(
            onTap: () => Navigator.pushNamed(context, ProfilePage.route),
            icon: Icons.person_rounded,
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
