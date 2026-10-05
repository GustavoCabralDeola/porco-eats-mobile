import 'package:flutter/material.dart';

class OrderListFilter extends StatelessWidget {
  const OrderListFilter({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.selected = false,
  });

  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFFFFC928) : const Color(0xFFEDEBE8),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF292929),
                ),
              ),
              if (icon != null) ...[
                const SizedBox(width: 3),
                Icon(icon, size: 16, color: const Color(0xFF292929)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
