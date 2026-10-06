import 'package:flutter/material.dart';
import 'package:porco_eats/features/login/controllers/login_controller.dart';
import 'package:porco_eats/features/order_list/controllers/orders_list_controller.dart';
import 'package:porco_eats/models/enums/order_status.dart';
import 'package:porco_eats/models/enums/user_role.dart';
import 'package:porco_eats/shared/widgets/cards/app_order_card.dart';
import 'package:porco_eats/shared/widgets/navigation/app_home_navigation_bar_customer.dart';
import 'package:porco_eats/shared/widgets/navigation/app_home_navigation_bar_manager.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatelessWidget {
  static String route = '/orders';

  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<OrderListController>();
    final hasFilters = controller.hasFilters;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F6F3),
      bottomNavigationBar: Consumer<LoginController>(
        builder: (context, controller, child) {
          return controller.user?.role == UserRole.customer
              ? const AppHomeNavigationBarCustomer(selectedIndex: 1)
              : const AppHomeNavigationBarManager(selectedIndex: 1);
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

        title: controller.isSearching
            ? TextField(
                controller: controller.searchController,
                autofocus: true,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                decoration: const InputDecoration(
                  hintText: 'Buscar pedido ou cliente',
                  hintStyle: TextStyle(color: Colors.white70, fontSize: 14),
                  border: InputBorder.none,
                ),
              )
            : const Text(
                'Pedidos',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),

        actions: [
          IconButton(
            tooltip: controller.isSearching ? 'Fechar busca' : 'Buscar pedidos',
            onPressed: controller.toggleSearch,
            icon: Icon(
              controller.isSearching ? Icons.close : Icons.search,
              size: 23,
            ),
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
                _buildFilter(
                  label: 'Todos',
                  selected: !hasFilters,
                  onTap: controller.clearFilters,
                ),
                const SizedBox(width: 8),
                _buildFilter(
                  label: controller.selectedCustomer ?? 'Cliente',
                  selected: controller.selectedCustomer != null,
                  icon: Icons.keyboard_arrow_down,
                  onTap: () => _showClientFilter(context, controller),
                ),
                const SizedBox(width: 8),
                _buildFilter(
                  label: controller.statusFilterLabel,
                  selected: controller.hasStatusFilter,
                  icon: Icons.keyboard_arrow_down,
                  onTap: () => _showStatusFilter(context, controller),
                ),
                Spacer(),
                Material(
                  color: const Color(0xFFEDEBE8),
                  shape: const CircleBorder(),
                  child: IconButton(
                    tooltip: 'Abrir filtros',
                    onPressed: () => _showAdvancedFilters(context, controller),
                    icon: const Icon(Icons.filter_list, size: 19),
                  ),
                ),
              ],
            ),
          ),

          Expanded(child: _buildOrdersList(controller)),
        ],
      ),
    );
  }

  Widget _buildFilter({
    required String label,
    bool selected = false,
    IconData? icon,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
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

  Widget _buildOrdersList(OrderListController controller) {
    if (controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              controller.errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xFF292929)),
            ),
            TextButton(
              onPressed: controller.loadOrdersFromStorage,
              child: const Text('Tentar novamente'),
            ),
          ],
        ),
      );
    }

    final orders = controller.filteredOrders;
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
          child: AppOrderCard(order: order),
        );
      },
    );
  }

  void _showClientFilter(BuildContext context, OrderListController controller) {
    final customers = controller.customers;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
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
                    controller.setSelectedCustomer(null);
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
                              controller.setSelectedCustomer(customer);
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
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
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
                TextField(
                  controller: controller.searchController,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'ID do pedido ou nome do cliente',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: controller.searchController.text.isEmpty
                        ? null
                        : IconButton(
                            tooltip: 'Limpar busca',
                            onPressed: controller.clearSearch,
                            icon: const Icon(Icons.close),
                          ),
                    border: const OutlineInputBorder(),
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
      shape: const RoundedRectangleBorder(
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
              _buildStatusOption(sheetContext, controller, null, 'Todos'),
              ...OrderStatus.values.map(
                (status) => _buildStatusOption(
                  sheetContext,
                  controller,
                  status,
                  status.label,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatusOption(
    BuildContext sheetContext,
    OrderListController controller,
    OrderStatus? status,
    String label,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label, style: const TextStyle(fontSize: 15)),
      onTap: () {
        controller.setSelectedStatus(status);
        Navigator.pop(sheetContext);
      },
    );
  }
}
