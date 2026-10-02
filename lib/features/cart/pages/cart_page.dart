import 'package:flutter/material.dart';
import 'package:porco_eats/features/cart/controllers/cart_controller.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  static String routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    return Consumer<CartController>(
      builder: (context, cartController, child) {
        return Scaffold(
          appBar: AppBar(title: const Text('Cart')),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartController.productsInCart.length,
                  itemBuilder: (context, index) {
                    final item = cartController.productsInCart[index];
                    return ListTile(
                      title: Text(item.name),
                      subtitle: Text('R\$ ${item.price}'),
                      trailing: Text('x${cartController.getQuantity(item)}'),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Handle checkout logic here
                  },
                  child: const Text('Confirm'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
