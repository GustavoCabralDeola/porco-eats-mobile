import 'package:flutter/material.dart';
import 'package:porco_eats/features/order_list/controllers/order_list_status.dart';
import 'package:porco_eats/models/customer_order.dart';
import 'package:porco_eats/models/enums/order_status.dart' show OrderStatus;


class OrderCard extends StatelessWidget {


  const OrderCard({
    super.key, required this.customerOrder,
   
  });
  final CustomerOrder customerOrder;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '#${customerOrder.id}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(customerOrder.customerName),
                  ],
                ),

                const SizedBox(height: 5),

                // Text(
                //   '${customerOrder.} • ${customerOrder.time}',
                //   style: const TextStyle(
                //     fontSize: 9,
                //     color: Colors.grey,
                //   ),
                // ),

                const SizedBox(height: 3),

                Text(
                  '${customerOrder.total}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          OrderListStatus(
            status: customerOrder.status.toString(),
          ),

          const SizedBox(width: 5),

          const Icon(
            Icons.chevron_right,
          ),
        ],
      ),
    );
  }
}