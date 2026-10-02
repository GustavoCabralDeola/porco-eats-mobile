import 'package:flutter/material.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';

class AppOrderItem extends StatelessWidget {
  const AppOrderItem({
    super.key,
    required this.orderId,
    required this.customerName,
    required this.status,
    required this.statusColor,
    required this.total,
    this.subtitle,
  });

  final String orderId;
  final String customerName;
  final String status;
  final Color statusColor;
  final String total;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.borderInputColor)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 42,
            child: Text(
              orderId,
              style: const TextStyle(
                color: AppColors.darkBrown,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cliente: $customerName',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.subTitle,
                    fontSize: 11,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: const TextStyle(
                      color: AppColors.subTitle,
                      fontSize: 10,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: const TextStyle(
                color: AppColors.fullWhite,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            total,
            style: const TextStyle(
              color: AppColors.darkBrown,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 6),
          const Icon(Icons.chevron_right, color: AppColors.subTitle, size: 20),
        ],
      ),
    );
  }
}
