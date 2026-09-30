

import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  String selectedFilter = 'Todos';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F6F3),

      appBar: AppBar(
        backgroundColor: const Color(0xFF351708),
        foregroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),

        title: const Text(
          'Pedidos',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {
             //botão de pesquisa do controller
            },
            icon: const Icon(
              Icons.search,
              size: 22,
            ),
          ),
        ],
      ),

      body: Column(
        children: [

         
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            child: Row(
              children: [

                _buildFilter(
                  label: 'Todos',
                  selected: selectedFilter == 'Todos',
                  onTap: () {
                    setState(() {
                      selectedFilter = 'Todos';
                    });
                  },
                ),

                const SizedBox(width: 8),

                _buildFilter(
                  label: 'Cliente',
                  icon: Icons.keyboard_arrow_down,
                  onTap: () {
                    _showClientFilter();
                  },
                ),

                const SizedBox(width: 8),

                _buildFilter(
                  label: 'Status',
                  icon: Icons.keyboard_arrow_down,
                  onTap: () {
                    _showStatusFilter();
                  },
                ),

                const Spacer(),

                // Filtro
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDEBE8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: IconButton(
                    onPressed: () {
                      // botão de filtro do controller
                    },
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.filter_list,
                      size: 17,
                    ),
                  ),
                ),
              ],
            ),
          ),

          
          Expanded(
            child: _buildOrdersList(),
          ),
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 9,
        ),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFFFC928)
              : const Color(0xFFEDEBE8),
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
              const SizedBox(width: 3),

              Icon(
                icon,
                size: 14,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildOrdersList() {
    // talvez listagem de pedidos da API

    return const SizedBox();
  }

  void _showClientFilter() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return const Padding(
          padding: EdgeInsets.all(24),
          child: SizedBox(
            height: 180,
            child: Center(
              child: Text(
                'Aguardando Clientes ',
              ),
            ),
          ),
        );
      },
    );
  }

  void _showStatusFilter() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                'Status do pedido',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),


              const ListTile(
                title: Text('Todos'),
              ),

              const ListTile(
                title: Text('Em preparo'),
              ),

              const ListTile(
                title: Text('Saiu para entrega'),
              ),

              const ListTile(
                title: Text('Entregue'),
              ),

              const ListTile(
                title: Text('Cancelado'),
              ),
            ],
          ),
        );
      },
    );
  }
}