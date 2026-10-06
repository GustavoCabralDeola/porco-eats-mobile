import 'package:flutter/material.dart';
import 'package:porco_eats/features/order_list/controllers/orders_list_controller.dart';
import 'package:porco_eats/models/enums/order_status.dart';

class AppStatusFilterBottomSheet extends StatelessWidget {
  const AppStatusFilterBottomSheet({super.key, required this.controller});

  final OrderListController controller;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Status do pedido',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            _buildStatusOption(context, null, 'Todos'),

            ...OrderStatus.values.map(
              (status) => _buildStatusOption(context, status, status.label),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusOption(
    BuildContext context,
    OrderStatus? status,
    String label,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label, style: const TextStyle(fontSize: 15)),
      trailing: controller.selectedStatus == status
          ? const Icon(Icons.check, color: Color(0xFF351708))
          : null,
      onTap: () {
        controller.setSelectedStatus(status);
        Navigator.pop(context);
      },
    );
  }
}
