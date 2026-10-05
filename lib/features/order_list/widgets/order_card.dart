import 'package:flutter/material.dart';
import 'package:porco_eats/features/details/order_details_page.dart';
import 'package:porco_eats/features/order_list/widgets/order_status_badge.dart';
import 'package:porco_eats/models/customer_order.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order});

  final CustomerOrder order;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OrderDetailsPage(customerOrder: order),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFECEAE6)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A351708),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
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
            OrderStatusBadge(status: order.status),
            const SizedBox(width: 3),
            const Icon(Icons.chevron_right, color: Color(0xFF8A8580)),
          ],
        ),
      ),
    );
  }
}
