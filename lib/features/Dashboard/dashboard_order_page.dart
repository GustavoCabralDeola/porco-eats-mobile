import 'package:flutter/material.dart';
import 'package:porco_eats/features/login/controllers/login_controller.dart';
import 'package:porco_eats/shared/widgets/app_card_dashboard.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:porco_eats/shared/widgets/app_intro_text.dart';
import 'package:porco_eats/shared/widgets/app_header_default.dart';
import 'package:provider/provider.dart';

class DashboardOrderPage extends StatefulWidget {
  const DashboardOrderPage({super.key});

  static const String route = '/dashboard';

  @override
  State<DashboardOrderPage> createState() => _DashboardOrderPageState();
}

class _DashboardOrderPageState extends State<DashboardOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brownWhite,
      appBar: AppBar(
        backgroundColor: AppColors.brownWhite,
        elevation: 0,
        toolbarHeight: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 125,
                width: double.infinity,
                child: AppHeaderDefault(
                  children: [
                    Positioned(
                      left: 30,
                      top: 46,
                      child: Image(
                        image: const AssetImage(
                          'assets/images/porco_eats_images/logoporcoeats.png',
                        ),
                        height: 60,
                        width: 60,
                      ),
                    ),
                    Positioned(
                      left: 102,
                      top: 64,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'PORCO',
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.fullWhite,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'EATS',
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.yellowAgility,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 48,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.notifications_none,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 650,
                decoration: const BoxDecoration(
                  color: AppColors.fullWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 18, right: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Consumer<LoginController>(
                          builder: (context, controller, child) {
                            final userName = controller.user?.name ?? 'Usuário';

                            return AppIntroText(
                              title: 'Olá, $userName!',
                              subtitle: 'aqui está um resumo dos seus pedidos',
                            );
                          },
                        ),
                        const SizedBox(height: 18),
                        Row(
                          children: const [
                            Expanded(
                              child: AppCardDashboard(
                                compact: true,
                                icon: Icons.shopping_bag_outlined,
                                title: 'Recebidos',
                                description: '5',
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: AppCardDashboard(
                                compact: true,
                                icon: Icons.check_circle_outline,
                                title: 'Em preparo',
                                description: '3',
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: AppCardDashboard(
                                compact: true,
                                icon: Icons.delivery_dining_outlined,
                                title: 'Em entrega',
                                description: '2',
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: AppCardDashboard(
                                compact: true,
                                icon: Icons.check_rounded,
                                title: 'Entregues',
                                description: '18',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
