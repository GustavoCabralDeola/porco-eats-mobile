import 'package:flutter/material.dart';
import 'package:porco_eats/features/customer_order/controllers/customer_order_controller.dart';
import 'package:porco_eats/features/order_list/controllers/order_details_controller.dart';
import 'package:porco_eats/models/customer_order.dart';
import 'package:porco_eats/models/enums/order_status.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:porco_eats/shared/widgets/app_elevated_button.dart';
import 'package:porco_eats/shared/widgets/app_product_image.dart';
import 'package:provider/provider.dart';

class OrderDetailsPage extends StatelessWidget {
  final CustomerOrder customerOrder;
  static const String route = '/order-details';

  const OrderDetailsPage({super.key, required this.customerOrder});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          OrderDetailsController(initialStatus: customerOrder.status),
      child: _OrderDetailsView(customerOrder: customerOrder),
    );
  }
}

class _OrderDetailsView extends StatelessWidget {
  const _OrderDetailsView({required this.customerOrder});

  final CustomerOrder customerOrder;

  bool get _isCanceled {
    return customerOrder.status.name.toLowerCase() == 'cancelled' ||
        customerOrder.status.name.toLowerCase() == 'canceled' ||
        customerOrder.status.name.toLowerCase() == 'cancelado';
  }

  String _statusLabel(OrderStatus status) {
    switch (status.name.toLowerCase()) {
      case 'received':
        return 'Recebido';
      case 'preparing':
        return 'Em preparo';
      case 'outfordelivery':
        return 'Saiu para entrega';
      case 'delivered':
        return 'Entregue';
      case 'cancelled':
      case 'canceled':
      case 'cancelado':
        return 'Cancelado';
      default:
        return status.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<OrderDetailsController>();
    final order = customerOrder;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F6F3),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 82,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF351708),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 27,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Detalhes do pedido',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_horiz, color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            '#${order.id}',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF292929),
                            ),
                          ),
                        ),
                        _buildStatusChip(order.status),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfo(
                            icon: Icons.person_outline,
                            title: 'Cliente',
                            value: order.customerName,
                          ),
                        ),
                        Expanded(
                          child: _buildInfo(
                            icon: Icons.receipt_long_outlined,
                            title: 'Pedido',
                            value: '#${order.id}',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    _buildInfo(
                      icon: Icons.payments_outlined,
                      title: 'Total',
                      value: 'R\$ ${order.total.toStringAsFixed(2)}',
                    ),
                    const SizedBox(height: 22),
                    const Divider(color: Color(0xFFE5E2DE)),
                    const SizedBox(height: 16),
                    const Text(
                      'Itens do pedido',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...order.products.map((product) {
                      return _buildProductItem(
                        product.name,
                        product.price,
                        product.imageUrl,
                      );
                    }),
                    const SizedBox(height: 18),
                    if (_isCanceled) _buildCanceledMessage(),
                    const SizedBox(height: 18),
                    const Text(
                      'Atualizar status',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildStatusDropdown(
                      controller: controller,
                      enabled: !_isCanceled,
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: AppElevatedButton(
                        label: 'Confirmar alteração',
                        labelStyle: TextStyle(
                          color: AppColors.fullWhite,
                          fontWeight: FontWeight.w600,
                        ),
                        type: ButtonType.filled,
                        height: 48,
                        borderRadius: BorderRadius.circular(10),
                        onPressed: _isCanceled
                            ? null
                            : () => _confirmStatus(context, controller),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(OrderStatus status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: _statusColor(status),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _statusLabel(status),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Color _statusColor(OrderStatus status) {
    switch (status.name.toLowerCase()) {
      case 'preparing':
        return const Color(0xFFFFC928);
      case 'outfordelivery':
        return const Color(0xFF8D3B25);
      case 'delivered':
        return const Color(0xFF24934B);
      case 'cancelled':
      case 'canceled':
      case 'cancelado':
        return const Color(0xFFE52B2B);
      default:
        return const Color(0xFF8D3B25);
    }
  }

  Widget _buildInfo({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 21, color: const Color(0xFF4A4A4A)),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 10, color: Color(0xFF777777)),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProductItem(String name, double price, String imageUrl) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFE8E5E1))),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFFF0EEEB),
            ),
            clipBehavior: Clip.antiAlias,
            child: AppProductImage(imageUrl: imageUrl),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'R\$ ${price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF666666),
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${customerOrder.quantity}x',
            style: const TextStyle(fontSize: 11, color: Color(0xFF777777)),
          ),
        ],
      ),
    );
  }

  Widget _buildCanceledMessage() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE9E7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        children: [
          Icon(Icons.lock_outline, color: Color(0xFFE52B2B), size: 20),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Este pedido não pode ser alterado pois já foi cancelado.',
              style: TextStyle(
                fontSize: 11,
                color: Color(0xFFE52B2B),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusDropdown({
    required OrderDetailsController controller,
    required bool enabled,
  }) {
    return Container(
      width: double.infinity,
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: enabled ? Colors.white : const Color(0xFFEDEBE8),
        border: Border.all(color: const Color(0xFFD5D1CC)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<OrderStatus>(
          value: controller.selectedStatus,
          isExpanded: true,
          onChanged: enabled
              ? (status) {
                  if (status == null) return;

                  controller.setSelectedStatus(status);
                }
              : null,
          items: OrderStatus.values.map((status) {
            return DropdownMenuItem<OrderStatus>(
              value: status,
              child: Text(
                _statusLabel(status),
                style: const TextStyle(fontSize: 12),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Future<void> _confirmStatus(
    BuildContext context,
    OrderDetailsController controller,
  ) async {
    final selectedStatus = controller.selectedStatus;
    if (selectedStatus == customerOrder.status) {
      return;
    }

    try {
      await context.read<CustomerOrderController>().updateOrderStatus(
        customerOrder.id,
        selectedStatus,
      );
      if (!context.mounted) return;
      Navigator.pop(context, selectedStatus);
    } catch (error) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Não foi possível atualizar o status: $error')),
      );
    }
  }
}
