import 'package:flutter/material.dart' show StatelessWidget, Widget, BuildContext, Color, EdgeInsets, BorderRadius, BoxDecoration, Colors, FontWeight, TextStyle, Text, Container;


class OrderListStatus extends StatelessWidget {
  final String status;

  const OrderListStatus({
    super.key,
    required this.status,
  });

  Color get getStatusColor {
    switch (status) {
      case 'Em preparo':
        return const Color(0xFFFFC928);

      case 'Saiu para entrega':
        return const Color(0xFF8D3B25);

      case 'Entregue':
        return const Color(0xFF24934B);

      case 'Cancelado':
        return const Color(0xFFE52B2B);

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: getStatusColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 9,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}