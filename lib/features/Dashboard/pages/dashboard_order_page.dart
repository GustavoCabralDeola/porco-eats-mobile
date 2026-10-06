import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:porco_eats/features/Dashboard/controllers/dashboard_order_controller.dart';
import 'package:porco_eats/features/home/pages/home_page.dart';
import 'package:porco_eats/features/order_list/pages/orders_list_page.dart';
import 'package:porco_eats/features/login/controllers/login_controller.dart';
import 'package:porco_eats/models/customer_order.dart';
import 'package:porco_eats/models/enums/order_status.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:porco_eats/shared/widgets/app_intro_text.dart';
import 'package:porco_eats/shared/widgets/app_order_item.dart';
import 'package:porco_eats/shared/widgets/app_order_section.dart';
import 'package:porco_eats/shared/widgets/cards/app_card_dashboard.dart';
import 'package:porco_eats/shared/widgets/headers/app_header_default.dart';
import 'package:porco_eats/shared/widgets/navigation/app_home_navigation_bar_manager.dart';
import 'package:provider/provider.dart';

class DashboardOrderPage extends StatefulWidget {
  const DashboardOrderPage({super.key});

  static const String route = '/dashboard';

  @override
  State<DashboardOrderPage> createState() => _DashboardOrderPageState();
}

class _DashboardOrderPageState extends State<DashboardOrderPage> {
  @override
  void initState() {
    super.initState();
    unawaited(
      context.read<DashboardOrderController>().loadOrders(forceRefresh: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brownWhite,
      bottomNavigationBar: const AppHomeNavigationBarManager(selectedIndex: 2),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 115,
                  width: double.infinity,
                  child: AppHeaderDefault(
                    children: [
                      Positioned(
                        left: 10,
                        top: 22,
                        child: IconButton(
                          onPressed: () => Navigator.pushNamedAndRemoveUntil(
                            context,
                            HomePage.route,
                            (route) => false,
                          ),
                          icon: const Icon(Icons.arrow_back),
                          color: AppColors.fullWhite,
                          tooltip: 'Voltar para a página inicial',
                        ),
                      ),
                      Positioned(
                        left: 58,
                        top: 40,
                        child: Image(
                          image: const AssetImage(
                            'assets/images/porco_eats_images/logoporcoeats.png',
                          ),
                          height: 60,
                          width: 60,
                        ),
                      ),
                      Positioned(
                        left: 130,
                        top: 48,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'PORCO',
                              style: GoogleFonts.anton(
                                fontSize: 15,
                                color: AppColors.fullWhite,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'EATS',
                              style: GoogleFonts.anton(
                                fontSize: 15,
                                color: AppColors.yellowAgility,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Positioned(
                        left: 130,
                        top: 73,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Seu pedido,',
                              style: GoogleFonts.anton(
                                fontSize: 12,
                                color: AppColors.fullWhite,
                              ),
                            ),
                            SizedBox(width: 4),
                            Text(
                              'nossa missão!',
                              style: GoogleFonts.anton(
                                fontSize: 12,
                                color: AppColors.redDelivery,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Positioned(
                        right: 20,
                        top: 40,
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
                const SizedBox(height: 8),
                Container(
                  constraints: BoxConstraints(
                    minHeight: (constraints.maxHeight - 123)
                        .clamp(0.0, double.infinity)
                        .toDouble(),
                  ),
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
                              final userName =
                                  controller.user?.name ?? 'Usuário';

                              return AppIntroText(
                                title: 'Olá, $userName!',
                                subtitle:
                                    'aqui está um resumo dos seus pedidos',
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 18),
                        Consumer<DashboardOrderController>(
                          builder: (context, controller, child) {
                            if (controller.isLoading) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(24),
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            if (controller.errorMessage != null) {
                              return Center(
                                child: Column(
                                  children: [
                                    Text(
                                      controller.errorMessage!,
                                      textAlign: TextAlign.center,
                                    ),
                                    TextButton(
                                      onPressed: controller.loadOrders,
                                      child: const Text('Tentar novamente'),
                                    ),
                                  ],
                                ),
                              );
                            }

                            return _buildDashboardOrders(context, controller);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDashboardOrders(
    BuildContext context,
    DashboardOrderController controller,
  ) {
    return Column(
      children: [
        SizedBox(
          height: 133,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              SizedBox(
                width: 92,
                child: AppCardDashboard(
                  compact: true,
                  icon: Icons.receipt_long,
                  title: 'Recebidos',
                  description: controller
                      .countForStatus(OrderStatus.received)
                      .toString(),
                  backgroundColor: AppColors.redDelivery,
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 92,
                child: AppCardDashboard(
                  compact: true,
                  icon: Icons.access_time_rounded,
                  title: 'Em preparo',
                  description: controller
                      .countForStatus(OrderStatus.preparing)
                      .toString(),
                  backgroundColor: AppColors.yellowAgility,
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 92,
                child: AppCardDashboard(
                  compact: true,
                  icon: Icons.local_shipping_outlined,
                  title: 'Em entrega',
                  description: controller
                      .countForStatus(OrderStatus.outForDelivery)
                      .toString(),
                  backgroundColor: AppColors.darkBrown,
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 92,
                child: AppCardDashboard(
                  compact: true,
                  icon: Icons.check_circle_outline,
                  title: 'Entregues',
                  description: controller
                      .countForStatus(OrderStatus.delivered)
                      .toString(),
                  backgroundColor: const Color(0xFF159447),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 92,
                child: AppCardDashboard(
                  compact: true,
                  icon: Icons.cancel_outlined,
                  title: 'Cancelados',
                  description: controller
                      .countForStatus(OrderStatus.cancelled)
                      .toString(),
                  backgroundColor: AppColors.subTitle,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        AppOrderSection(
          title: 'Pedidos em andamento',
          children: controller.ongoingOrders.isEmpty
              ? [_buildEmptyOrdersMessage('Nenhum pedido em andamento')]
              : controller.ongoingOrders
                    .map((order) => _buildOrderItem(order, controller))
                    .toList(),
        ),
        const SizedBox(height: 30),
        AppOrderSection(
          title: 'Últimos pedidos',
          actionLabel: 'Ver todos',
          onActionPressed: () => Navigator.pushNamed(context, OrdersPage.route),
          children: controller.recentOrders.isEmpty
              ? [_buildEmptyOrdersMessage('Nenhum pedido finalizado ainda')]
              : controller.recentOrders
                    .map((order) => _buildOrderItem(order, controller))
                    .toList(),
        ),
      ],
    );
  }

  Widget _buildOrderItem(
    CustomerOrder order,
    DashboardOrderController controller,
  ) {
    return AppOrderItem(
      orderId: '#${order.id}',
      customerName: order.customerName.trim().isEmpty
          ? 'Cliente não identificado'
          : order.customerName,
      status: order.status.label,
      statusColor: controller.colorForStatus(order.status),
      total: controller.formatCurrency(order.total),
      subtitle: controller.formatItemCount(order),
    );
  }

  Widget _buildEmptyOrdersMessage(String message) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        message,
        style: const TextStyle(color: AppColors.subTitle, fontSize: 12),
      ),
    );
  }
}
