import 'package:flutter/material.dart';

class OrderListFilter extends StatelessWidget {

final String label;
final IconData? icon;
final VoidCallback? onPressed;

const OrderListFilter({
  super.key,
  required this.label,
  this.icon,
  this.onPressed,
});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFEDEBE8),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (icon != null) ...[
              const SizedBox(width: 4),
              Icon(
                icon,
                size: 13,
              ),
            ],
          ],
        ),
      ),
    );
  }
}