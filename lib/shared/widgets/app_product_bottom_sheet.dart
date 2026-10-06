import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:porco_eats/features/cart/controllers/cart_controller.dart';
import 'package:porco_eats/models/product.dart';
import 'package:provider/provider.dart';

void showProductBottomSheet(BuildContext context, Product product) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    isDismissible: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black87,
    builder: (context) => DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.3,
      maxChildSize: 0.7,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Puxador
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // Conteúdo
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Imagem
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            _productDetailImage(product),
                            width: double.infinity,
                            height: 280,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                            cacheWidth: 1000,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Nome
                        Text(
                          product.name,
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Restaurante
                        Text(
                          product.restaurant,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Avaliação
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              product.avaliation.toString(),
                              style: GoogleFonts.poppins(fontSize: 14),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Descrição
                        Text(
                          'Descrição',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          product.description ?? 'Sem descrição',
                          style: GoogleFonts.poppins(fontSize: 13),
                        ),

                        const SizedBox(height: 30),

                        // Preço + ações do carrinho
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'R\$ ${product.price.toStringAsFixed(2)}',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Consumer<CartController>(
                              builder: (context, cart, child) {
                                final quantity = cart.getQuantity(product);

                                if (quantity > 0) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.orange.shade50,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          onPressed: () =>
                                              cart.decreaseQuantity(product),
                                          icon: const Icon(
                                            Icons.remove,
                                            size: 18,
                                          ),
                                          color: Colors.orange,
                                          splashRadius: 18,
                                        ),
                                        Text(
                                          quantity.toString(),
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orange,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () =>
                                              cart.increaseQuantity(product),
                                          icon: const Icon(
                                            Icons.add,
                                            size: 18,
                                          ),
                                          color: Colors.orange,
                                          splashRadius: 18,
                                        ),
                                      ],
                                    ),
                                  );
                                }

                                return ElevatedButton.icon(
                                  onPressed: () {
                                    cart.addToCart(product);
                                    ScaffoldMessenger.of(
                                      context,
                                    ).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          '${product.name} adicionado ao carrinho!',
                                          style: GoogleFonts.poppins(),
                                        ),
                                        duration: const Duration(seconds: 2),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.shopping_cart),
                                  label: const Text('Adicionar'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 12,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

String _productDetailImage(Product product) {
  if (product.id == 8) {
    return 'assets/images/porco_eats_images/products/pizzacalabresa.jpg';
  }
  return product.imageUrl;
}
