import 'package:flutter/material.dart';
import 'package:porco_eats/features/order_list/pages/order_details_page.dart';
import 'package:porco_eats/models/customer_order.dart';
import 'package:porco_eats/models/enums/order_status.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';

class AppOrderCard extends StatelessWidget {
  const AppOrderCard({super.key, required this.order});

  final CustomerOrder order;

  @override
  Widget build(BuildContext context) {
    final statusColor = switch (order.status) {
      OrderStatus.received => AppColors.redDelivery,
      OrderStatus.preparing => AppColors.yellowAgility,
      OrderStatus.outForDelivery => AppColors.darkBrown,
      OrderStatus.delivered => AppColors.greenDelivered,
      OrderStatus.cancelled => AppColors.subTitle,
    };
    final statusTextColor =
        order.status == OrderStatus.received ||
            order.status == OrderStatus.preparing
        ? AppColors.darkBrown
        : AppColors.fullWhite;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderInputColor),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A351708),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: () {
            Navigator.push<OrderStatus>(
              context,
              MaterialPageRoute<OrderStatus>(
                builder: (_) => OrderDetailsPage(customerOrder: order),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '#${order.id}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              order.customerName,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF45413D),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 7),
                      Text(
                        '${order.quantity} ${order.quantity == 1 ? 'item' : 'itens'}',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF8A8580),
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'R\$ ${order.total.toStringAsFixed(2).replaceAll('.', ',')}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF292521),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    order.status.label,
                    style: TextStyle(
                      color: statusTextColor,
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 3),
                const Icon(Icons.chevron_right, color: Color(0xFF8A8580)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
