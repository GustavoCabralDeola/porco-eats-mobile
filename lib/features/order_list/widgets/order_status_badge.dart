import 'package:flutter/material.dart';
import 'package:porco_eats/models/enums/order_status.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';

class OrderStatusBadge extends StatelessWidget {
  const OrderStatusBadge({super.key, required this.status});

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      OrderStatus.received || OrderStatus.preparing => AppColors.yellowAgility,
      OrderStatus.outForDelivery => AppColors.darkBrown,
      OrderStatus.delivered => AppColors.categoryBackground,
      OrderStatus.cancelled => AppColors.redDelivery,
    };
    final textColor =
        status == OrderStatus.received ||
            status == OrderStatus.preparing ||
            status == OrderStatus.delivered
        ? AppColors.darkBrown
        : AppColors.fullWhite;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.label,
        style: TextStyle(
          color: textColor,
          fontSize: 9,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
