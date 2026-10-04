import 'package:flutter/material.dart';
import 'package:porco_eats/features/order_list/pages/orders_list_page.dart' show OrdersPage;

class OrderButton extends StatelessWidget {
  const OrderButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pushNamed(
          context,
          OrdersPage.route,
        );
      },
      icon: const Icon(
        Icons.receipt_long,
      ),
    );
  }
}