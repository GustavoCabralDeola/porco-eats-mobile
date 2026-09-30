import 'package:flutter/material.dart';
import 'package:porco_eats/features/order_list/controllers/order_list_status.dart';


class OrderCard extends StatelessWidget {
  final String number;
  final String client;
  final String date;
  final String time;
  final String value;
  final String status;

  const OrderCard({
    super.key,
    required this.number,
    required this.client,
    required this.date,
    required this.time,
    required this.value,
    required this.status,
  });

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
                      '#$number',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(client),
                  ],
                ),

                const SizedBox(height: 5),

                Text(
                  '$date • $time',
                  style: const TextStyle(
                    fontSize: 9,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          OrderStatusChip(
            status: status,
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