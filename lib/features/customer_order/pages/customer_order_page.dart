import 'package:flutter/material.dart';
import 'package:porco_eats/features/customer_order/controllers/customer_order_controller.dart';
import 'package:porco_eats/features/login/controllers/login_controller.dart';
import 'package:porco_eats/models/customer_order.dart';
import 'package:porco_eats/models/enums/order_status.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:porco_eats/shared/widgets/navigation/app_home_navigation_bar_customer.dart';
import 'package:porco_eats/shared/widgets/app_product_image.dart';
import 'package:provider/provider.dart';

class CustomerOrderPage extends StatelessWidget {
  const CustomerOrderPage({super.key});

  static const String route = '/customer-orders';

  @override
  Widget build(BuildContext context) {
    final orderController = context.watch<CustomerOrderController>();
    final user = context.watch<LoginController>().user;
    final orders = orderController.ordersForCustomer(user);
    final activeOrders = orders
        .where(
          (order) =>
              order.status != OrderStatus.delivered &&
              order.status != OrderStatus.cancelled,
        )
        .toList(growable: false);
    final deliveredOrders = orders
        .where((order) => order.status == OrderStatus.delivered)
        .toList(growable: false);
    final cancelledOrders = orders
        .where((order) => order.status == OrderStatus.cancelled)
        .toList(growable: false);

    return Scaffold(
      backgroundColor: AppColors.brownWhite,
      appBar: AppBar(
        backgroundColor: AppColors.darkBrown,
        foregroundColor: AppColors.fullWhite,
        title: const Text(
          'Meus pedidos',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      bottomNavigationBar: AppHomeNavigationBarCustomer(selectedIndex: 1),
      body: orderController.isLoading && orderController.orders.isEmpty
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.redDelivery),
            )
          : orderController.errorMessage != null &&
                orderController.orders.isEmpty
          ? _OrderLoadError(
              message: orderController.errorMessage!,
              onRetry: orderController.loadOrders,
            )
          : ListView(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 24),
              children: [
                const Text(
                  'Histórico de pedidos',
                  style: TextStyle(
                    color: AppColors.darkBrown,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Acompanhe todos os seus pedidos realizados.',
                  style: TextStyle(color: AppColors.subTitle, fontSize: 13),
                ),
                if (orderController.errorMessage != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    orderController.errorMessage!,
                    style: const TextStyle(color: AppColors.redDelivery),
                  ),
                  TextButton(
                    onPressed: orderController.loadOrders,
                    child: const Text('Tentar novamente'),
                  ),
                ],
                const SizedBox(height: 18),
                _OrderSection(
                  title: 'Em andamento',
                  count: activeOrders.length,
                  countColor: AppColors.yellowAgility,
                  initiallyExpanded: true,
                  emptyMessage: 'Você não tem pedidos em andamento.',
                  orders: activeOrders,
                  isActive: true,
                ),
                const SizedBox(height: 10),
                _OrderSection(
                  title: 'Entregues',
                  count: deliveredOrders.length,
                  countColor: AppColors.greenDelivered,
                  emptyMessage: 'Nenhum pedido entregue ainda.',
                  orders: deliveredOrders,
                ),
                const SizedBox(height: 10),
                _OrderSection(
                  title: 'Cancelados',
                  count: cancelledOrders.length,
                  countColor: AppColors.redDelivery,
                  emptyMessage: 'Nenhum pedido cancelado.',
                  orders: cancelledOrders,
                ),
              ],
            ),
    );
  }
}

class _OrderLoadError extends StatelessWidget {
  const _OrderLoadError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: onRetry,
              child: const Text('Tentar novamente'),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderSection extends StatelessWidget {
  const _OrderSection({
    required this.title,
    required this.count,
    required this.countColor,
    required this.emptyMessage,
    required this.orders,
    this.initiallyExpanded = false,
    this.isActive = false,
  });

  final String title;
  final int count;
  final Color countColor;
  final String emptyMessage;
  final List<CustomerOrder> orders;
  final bool initiallyExpanded;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: initiallyExpanded,
        tilePadding: const EdgeInsets.symmetric(horizontal: 4),
        childrenPadding: const EdgeInsets.fromLTRB(0, 0, 0, 2),
        title: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: AppColors.darkBrown,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              constraints: const BoxConstraints(minWidth: 23, minHeight: 23),
              padding: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: countColor,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                '$count',
                style: const TextStyle(
                  color: AppColors.darkBrown,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        children: orders.isEmpty
            ? [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      emptyMessage,
                      style: const TextStyle(
                        color: AppColors.subTitle,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ]
            : orders
                  .map(
                    (order) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _CustomerOrderCard(
                        order: order,
                        isActive: isActive,
                      ),
                    ),
                  )
                  .toList(),
      ),
    );
  }
}

class _CustomerOrderCard extends StatelessWidget {
  const _CustomerOrderCard({required this.order, required this.isActive});

  final CustomerOrder order;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final product = order.firstProduct;
    final statusColor = switch (order.status) {
      OrderStatus.delivered => AppColors.greenDelivered,
      OrderStatus.cancelled => AppColors.redDelivery,
      _ => AppColors.yellowAgility,
    };

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.fullWhite,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFE8E5E1)),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 82,
                  height: 82,
                  child: product == null
                      ? const ColoredBox(
                          color: AppColors.brownWhite,
                          child: Icon(
                            Icons.fastfood_outlined,
                            color: AppColors.darkBrown,
                          ),
                        )
                      : AppProductImage(imageUrl: product.imageUrl),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product?.name ?? 'Pedido',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.darkBrown,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      product?.restaurant ?? 'Porco Eats',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.subTitle,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '#${order.id}  ·  ${_formatOrderDate(order)}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.subTitle,
                        fontSize: 11,
                      ),
                    ),
                    if (!isActive) ...[
                      const SizedBox(height: 6),
                      _StatusBadge(status: order.status, color: statusColor),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'R\$ ${order.total.toStringAsFixed(2).replaceAll('.', ',')}',
                style: const TextStyle(
                  color: AppColors.darkBrown,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          if (isActive) ...[
            const SizedBox(height: 15),
            _OrderProgress(status: order.status),
          ],
        ],
      ),
    );
  }

  String _formatOrderDate(CustomerOrder order) {
    final date = order.createdAt ?? _dateFromOrderId(order.id);
    if (date == null) return 'Data indisponível';

    final localDate = date.toLocal();
    final now = DateTime.now();
    final isToday =
        localDate.year == now.year &&
        localDate.month == now.month &&
        localDate.day == now.day;
    final dateLabel = isToday
        ? 'Hoje'
        : '${localDate.day.toString().padLeft(2, '0')}/'
              '${localDate.month.toString().padLeft(2, '0')}/'
              '${localDate.year}';
    final timeLabel =
        '${localDate.hour.toString().padLeft(2, '0')}:'
        '${localDate.minute.toString().padLeft(2, '0')}';
    return '$dateLabel, $timeLabel';
  }

  DateTime? _dateFromOrderId(String orderId) {
    final timestamp = int.tryParse(orderId);
    return timestamp == null
        ? null
        : DateTime.fromMillisecondsSinceEpoch(timestamp);
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status, required this.color});

  final OrderStatus status;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            status == OrderStatus.delivered ? Icons.check_circle : Icons.cancel,
            size: 13,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            status.label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderProgress extends StatelessWidget {
  const _OrderProgress({required this.status});

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    final currentStep = switch (status) {
      OrderStatus.outForDelivery => 1,
      _ => 0,
    };
    final steps = [
      status == OrderStatus.received
          ? (Icons.receipt_long_outlined, 'Recebido')
          : (Icons.restaurant, 'Em preparo'),
      (Icons.delivery_dining, 'Saiu para entrega'),
      (Icons.check_circle, 'Entregue'),
      (Icons.close, 'Cancelado'),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final stepSpacing = (constraints.maxWidth - 32) / (steps.length - 1);

        return Column(
          children: [
            SizedBox(
              height: 32,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 16,
                    right: 16,
                    child: Container(height: 2, color: const Color(0xFFE5E2DE)),
                  ),
                  if (currentStep > 0)
                    Positioned(
                      left: 16,
                      width: stepSpacing * currentStep,
                      child: Container(
                        height: 2,
                        color: AppColors.yellowAgility,
                      ),
                    ),
                  Row(
                    children: [
                      for (var index = 0; index < steps.length; index++)
                        Expanded(
                          child: Center(
                            child: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: index <= currentStep
                                    ? AppColors.yellowAgility
                                    : const Color(0xFFF2F1EF),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: index <= currentStep
                                      ? AppColors.yellowAgility
                                      : const Color(0xFFE5E2DE),
                                ),
                              ),
                              child: Icon(
                                steps[index].$1,
                                size: 16,
                                color: index <= currentStep
                                    ? AppColors.darkBrown
                                    : AppColors.greyshade,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                for (var index = 0; index < steps.length; index++)
                  Expanded(
                    child: Text(
                      steps[index].$2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: index <= currentStep
                            ? AppColors.darkBrown
                            : AppColors.subTitle,
                        fontSize: 9,
                        fontWeight: index <= currentStep
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
