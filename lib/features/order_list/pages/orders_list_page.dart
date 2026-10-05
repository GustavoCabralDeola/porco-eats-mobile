import 'package:flutter/material.dart';
import 'package:porco_eats/features/login/controllers/login_controller.dart';
import 'package:porco_eats/features/order_list/controllers/orders_list_controller.dart';
import 'package:porco_eats/models/customer_order.dart';
import 'package:porco_eats/models/enums/order_status.dart';
import 'package:porco_eats/models/enums/user_role.dart';
import 'package:porco_eats/shared/widgets/app_home_footer_customer.dart';
import 'package:porco_eats/shared/widgets/app_home_footer_manager.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatefulWidget {
  static String route = '/orders';

  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final TextEditingController _searchController = TextEditingController();
  OrderStatus? _selectedStatus;
  String? _selectedCustomer;
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
    final hasFilters =
        _selectedStatus != null ||
        _selectedCustomer != null ||
        _searchController.text.trim().isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F6F3),
      bottomNavigationBar: Consumer<LoginController>(
        builder: (context, controller, child) {
          return controller.user?.role == UserRole.customer
              ? const AppHomeFooterCustomer()
              : const AppHomeFooterManager();
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
                onChanged: (_) => setState(() {}),
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
                _buildFilter(
                  label: 'Todos',
                  selected: !hasFilters,
                  onTap: _clearFilters,
                ),
                const SizedBox(width: 8),
                _buildFilter(
                  label: _selectedCustomer ?? 'Cliente',
                  selected: _selectedCustomer != null,
                  icon: Icons.keyboard_arrow_down,
                  onTap: _showClientFilter,
                ),
                const SizedBox(width: 8),
                _buildFilter(
                  label: _selectedStatus?.label ?? 'Status',
                  selected: _selectedStatus != null,
                  icon: Icons.keyboard_arrow_down,
                  onTap: _showStatusFilter,
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

  void _clearFilters() {
    setState(() {
      _selectedStatus = null;
      _selectedCustomer = null;
      _searchController.clear();
    });
  }

  List<CustomerOrder> _filterOrders(List<CustomerOrder> orders) {
    final query = _searchController.text.trim().toLowerCase();

    return orders.where((order) {
      final matchesStatus =
          _selectedStatus == null || order.status == _selectedStatus;
      final matchesCustomer =
          _selectedCustomer == null || order.customerName == _selectedCustomer;
      final matchesQuery =
          query.isEmpty ||
          order.id.toLowerCase().contains(query) ||
          order.customerName.toLowerCase().contains(query) ||
          order.products.any(
            (product) => product.name.toLowerCase().contains(query),
          );

      return matchesStatus && matchesCustomer && matchesQuery;
    }).toList();
  }

  Widget _buildOrderCard(CustomerOrder order) {
    final statusColor = switch (order.status) {
      OrderStatus.received || OrderStatus.preparing => const Color(0xFFFFC928),
      OrderStatus.outForDelivery => const Color(0xFF8D3B25),
      OrderStatus.delivered => const Color(0xFF24934B),
      OrderStatus.cancelled => const Color(0xFFE52B2B),
    };
    final statusTextColor =
        order.status == OrderStatus.received ||
            order.status == OrderStatus.preparing
        ? const Color(0xFF351708)
        : Colors.white;

    return Container(
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              order.status.label,
              style: TextStyle(
                color: statusTextColor,
                fontSize: 9,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 3),
          const Icon(Icons.chevron_right, color: Color(0xFF8A8580)),
        ],
      ),
    );
  }

  Widget _buildOrdersList() {
    return Consumer<OrderListController>(
      builder: (context, controller, _) {
        final orders = _filterOrders(controller.allOrders);
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
              child: _buildOrderCard(order),
            );
          },
        );
      },
    );
  }

  void _showClientFilter() {
    final customers =
        context
            .read<OrderListController>()
            .allOrders
            .map((order) => order.customerName.trim())
            .where((name) => name.isNotEmpty)
            .toSet()
            .toList()
          ..sort((first, second) => first.compareTo(second));

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
                    setState(() => _selectedCustomer = null);
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
                            trailing: _selectedCustomer == customer
                                ? const Icon(
                                    Icons.check,
                                    color: Color(0xFF351708),
                                  )
                                : null,
                            onTap: () {
                              setState(() => _selectedCustomer = customer);
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

  void _showAdvancedFilters() {
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
                  controller: _searchController,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'ID do pedido ou nome do cliente',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isEmpty
                        ? null
                        : IconButton(
                            tooltip: 'Limpar busca',
                            onPressed: () {
                              _searchController.clear();
                              setState(() {});
                            },
                            icon: const Icon(Icons.close),
                          ),
                    border: const OutlineInputBorder(),
                  ),
                  onChanged: (_) => setState(() {}),
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

  
  void _showStatusFilter() {
    showModalBottomSheet(
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
      onTap: () {
        setState(() => _selectedStatus = status);
        Navigator.pop(sheetContext);
      },
    );
  }
}
