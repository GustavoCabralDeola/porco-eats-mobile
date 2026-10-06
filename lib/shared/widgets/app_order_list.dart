import 'package:flutter/material.dart';
import 'package:porco_eats/features/order_list/controllers/orders_list_controller.dart';
import 'package:porco_eats/shared/widgets/cards/app_order_card.dart';

class AppOrderList extends StatelessWidget {
  const AppOrderList({super.key, required this.controller});

  final OrderListController controller;

  @override
  Widget build(BuildContext context) {
    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              controller.errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xFF292929)),
            ),
            TextButton(
              onPressed: controller.loadOrdersFromStorage,
              child: const Text('Tentar novamente'),
            ),
          ],
        ),
      );
    }

    final orders = controller.filteredOrders;
    if (orders.isEmpty) {
      return const Center(
        child: Text(
          'Nenhum pedido encontrado',
          style: TextStyle(fontSize: 16, color: Color(0xFF292929)),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 20),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];

        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: AppOrderCard(order: order),
        );
      },
    );
  }
}
