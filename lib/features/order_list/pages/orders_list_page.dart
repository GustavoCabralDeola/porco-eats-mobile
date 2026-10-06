import 'dart:async';

import 'package:flutter/material.dart';
import 'package:porco_eats/features/order_list/widgets/order_card.dart';
import 'package:porco_eats/features/login/controllers/login_controller.dart';
import 'package:porco_eats/features/order_list/widgets/order_list_filter.dart';
import 'package:porco_eats/features/order_list/controllers/orders_list_controller.dart';
import 'package:porco_eats/models/enums/order_status.dart';
import 'package:porco_eats/models/enums/user_role.dart';
import 'package:porco_eats/shared/widgets/app_home_navigation_bar_customer.dart';
import 'package:porco_eats/shared/widgets/app_home_navigation_bar_manager.dart';
import 'package:provider/provider.dart';

import '../../../shared/widgets/app_order_list.dart';
import '../../../shared/widgets/filters/app_advanced_filter_bottom_sheet.dart';
import '../../../shared/widgets/filters/app_order_filters.dart';
import '../../../shared/widgets/filters/app_status_filter_bottom_sheet.dart';
import '../../../shared/widgets/order_app_bar.dart';

class OrdersPage extends StatelessWidget {
  static String route = '/orders';

  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();

    context.read<OrderListController>().loadOrdersFromStorage();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orderController = context.watch<OrderListController>();
    final hasFilters =
        orderController.selectedStatus != null ||
        orderController.selectedCustomer != null ||
        orderController.searchQuery.trim().isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F6F3),
      bottomNavigationBar: Consumer<LoginController>(
        builder: (context, controller, child) {
          return controller.user?.role == UserRole.customer
              ? const AppHomeNavigationBarCustomer()
              : const AppHomeNavigationBarManager();
        },
      ),

      
      appBar: AppBar(
        backgroundColor: const Color(0xFF351708),
        foregroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(26)),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, size: 26),
        ),

        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration: const InputDecoration(
                  hintText: 'Buscar pedido ou cliente',
                  hintStyle: TextStyle(color: Colors.white70, fontSize: 14),
                  border: InputBorder.none,
                ),
                onChanged: context.read<OrderListController>().setSearchQuery,
              )
            : const Text(
                'Pedidos',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),

        actions: [
          IconButton(
            tooltip: _isSearching ? 'Fechar busca' : 'Buscar pedidos',
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) _searchController.clear();
                if (!_isSearching) {
                  context.read<OrderListController>().setSearchQuery('');
                }
              });
            },
            icon: Icon(_isSearching ? Icons.close : Icons.search, size: 23),
          ),

          const SizedBox(width: 6),
        ],
      ),

      body: Column(
        children: [
         
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 12, 12),
            child: Row(
              children: [
                OrderListFilter(
                  label: 'Todos',
                  selected: !hasFilters,
                  onPressed: _clearFilters,
                ),
                const SizedBox(width: 8),
                OrderListFilter(
                  label: orderController.selectedCustomer ?? 'Cliente',
                  selected: orderController.selectedCustomer != null,
                  icon: Icons.keyboard_arrow_down,
                  onPressed: _showClientFilter,
                ),
                const SizedBox(width: 8),
                OrderListFilter(
                  label: orderController.selectedStatus?.label ?? 'Status',
                  selected: orderController.selectedStatus != null,
                  icon: Icons.keyboard_arrow_down,
                  onPressed: _showStatusFilter,
                ),
                const Spacer(),
                Material(
                  color: const Color(0xFFEDEBE8),
                  shape: const CircleBorder(),
                  child: IconButton(
                    tooltip: 'Abrir filtros',
                    onPressed: _showAdvancedFilters,
                    icon: const Icon(Icons.filter_list, size: 19),
                  ),
                ),
              ],
            ),
          ),

          Expanded(child: _buildOrdersList()),
        ],
      ),
    );
  }

  void _clearFilters() {
    context.read<OrderListController>().clearFilters();
    _searchController.clear();
  }

  Widget _buildOrdersList() {
    return Consumer<OrderListController>(
      builder: (context, controller, _) {
        final orders = controller.orders;
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
              child: OrderCard(order: order),
            );
          },
        );
      },
    );
  }

  void _showClientFilter() {
    final controller = context.read<OrderListController>();
    final customers = controller.customers;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Filtrar por cliente',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Todos os clientes'),
                  onTap: () {
                    controller.setCustomer(null);
                    Navigator.pop(sheetContext);
                  },
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.sizeOf(sheetContext).height * 0.5,
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: customers
                        .map(
                          (customer) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(customer),
                            trailing: controller.selectedCustomer == customer
                                ? const Icon(
                                    Icons.check,
                                    color: Color(0xFF351708),
                                  )
                                : null,
                            onTap: () {
                              controller.setCustomer(customer);
                              Navigator.pop(sheetContext);
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
      },
    );
  }

  void _showAdvancedFilters(
    BuildContext context,
    OrderListController controller,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.fullWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              24,
              24,
              24,
              MediaQuery.viewInsetsOf(sheetContext).bottom + 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Filtrar pedidos',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _searchController,
                  builder: (context, value, _) => TextField(
                    controller: _searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: 'ID, cliente ou produto',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: value.text.isEmpty
                          ? null
                          : IconButton(
                              tooltip: 'Limpar busca',
                              onPressed: () {
                                _searchController.clear();
                                context
                                    .read<OrderListController>()
                                    .setSearchQuery('');
                              },
                              icon: const Icon(Icons.close),
                            ),
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: context
                        .read<OrderListController>()
                        .setSearchQuery,
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton(
                    onPressed: () => Navigator.pop(sheetContext),
                    child: const Text('Aplicar'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showStatusFilter(BuildContext context, OrderListController controller) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Status do pedido',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 16),

              _buildStatusOption(sheetContext, null, 'Todos'),
              ...OrderStatus.values.map(
                (status) =>
                    _buildStatusOption(sheetContext, status, status.label),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatusOption(
    BuildContext sheetContext,
    OrderStatus? status,
    String label,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label, style: const TextStyle(fontSize: 15)),
      trailing:
          context.read<OrderListController>().selectedStatus == status
          ? const Icon(Icons.check, color: Color(0xFF351708))
          : null,
      onTap: () {
        context.read<OrderListController>().setStatus(status);
        Navigator.pop(sheetContext);
      },
    );
  }
}
