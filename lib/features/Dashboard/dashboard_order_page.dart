import 'package:flutter/material.dart';
import 'package:porco_eats/features/login/controllers/login_controller.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:porco_eats/shared/widgets/app_intro_text.dart';
import 'package:porco_eats/shared/widgets/app_header_default.dart';
import 'package:porco_eats/shared/widgets/app_order_item.dart';
import 'package:porco_eats/shared/widgets/app_order_section.dart';
import 'package:porco_eats/shared/widgets/cards/app_card_dashboard.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 115,
              width: double.infinity,
              child: AppHeaderDefault(
                children: [
                  Positioned(
                    left: 30,
                    top: 20,
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
                    top: 38,
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
                    top: 22,
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
            Transform.translate(
              offset: const Offset(0, -32),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: AppColors.fullWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 14, 24, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Consumer<LoginController>(
                          builder: (context, controller, child) {
                            final userName = controller.user?.name ?? 'Usuário';

                            return AppIntroText(
                              title: 'Olá, $userName!',
                              subtitle: 'aqui está um resumo dos seus pedidos',
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          Expanded(
                            child: AppCardDashboard(
                              compact: true,
                              icon: Icons.shopping_bag_outlined,
                              title: 'Recebidos',
                              description: '5',
                              backgroundColor: AppColors.redDelivery,
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: AppCardDashboard(
                              compact: true,
                              icon: Icons.check_circle_outline,
                              title: 'Em preparo',
                              description: '3',
                              backgroundColor: AppColors.yellowAgility,
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: AppCardDashboard(
                              compact: true,
                              icon: Icons.delivery_dining_outlined,
                              title: 'Em entrega',
                              description: '2',
                              backgroundColor: AppColors.darkBrown,
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: AppCardDashboard(
                              compact: true,
                              icon: Icons.check_rounded,
                              title: 'Entregues',
                              description: '18',
                              backgroundColor: const Color(0xFF159447),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      AppOrderSection(
                        title: 'Pedidos em andamento',
                        children: [
                          AppOrderItem(
                            orderId: '#1024',
                            customerName: 'João Silva',
                            status: 'Em preparo',
                            statusColor: AppColors.yellowAgility,
                            total: 'R\$ 72,50',
                          ),
                          AppOrderItem(
                            orderId: '#1025',
                            customerName: 'Maria Souza',
                            status: 'Saiu para entrega',
                            statusColor: AppColors.redDelivery,
                            total: 'R\$ 48,90',
                          ),
                          AppOrderItem(
                            orderId: '#1026',
                            customerName: 'Carlos Lima',
                            status: 'Em preparo',
                            statusColor: AppColors.yellowAgility,
                            total: 'R\$ 36,80',
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      AppOrderSection(
                        title: 'Últimos pedidos',
                        actionLabel: 'Ver todos',
                        children: [
                          AppOrderItem(
                            orderId: '#1023',
                            customerName: 'Ana Paula',
                            status: 'Entregue',
                            statusColor: Color(0xFF159447),
                            total: 'R\$ 54,70',
                            subtitle: 'Hoje - 14:32',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
