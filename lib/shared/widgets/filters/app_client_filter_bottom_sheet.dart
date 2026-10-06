import 'package:flutter/material.dart';
import 'package:porco_eats/features/order_list/controllers/orders_list_controller.dart';

class AppClientFilterBottomSheet extends StatelessWidget {
  const AppClientFilterBottomSheet({super.key, required this.controller});

  final OrderListController controller;

  @override
  Widget build(BuildContext context) {
    final customers = controller.customers;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(24, 24, 24, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filtrar por cliente',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),

            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text('Todos os clientes'),
              onTap: () {
                controller.setSelectedCustomer(null);
                Navigator.pop(context);
              },
            ),

            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * 0.5,
              ),
              child: ListView(
                shrinkWrap: true,
                children: customers
                    .map(
                      (customer) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(customer),
                        trailing: controller.selectedCustomer == customer
                            ? Icon(Icons.check, color: Color(0xFF351708))
                            : null,
                        onTap: () {
                          controller.setSelectedCustomer(customer);
                          Navigator.pop(context);
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
