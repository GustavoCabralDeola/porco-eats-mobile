import 'package:flutter/material.dart';
import 'package:porco_eats/shared/widgets/app_promo_carousel.dart';

class AppHomeBannersRow extends StatelessWidget {
  const AppHomeBannersRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SizedBox(width: 10),
          AppPromoCarousel(
            banners: const [
              'assets/images/porco_eats_images/carousel_images/hamburguerCarousel.png',
              'assets/images/porco_eats_images/carousel_images/pizzaCarousel.png',
              'assets/images/porco_eats_images/carousel_images/sushiCarousel.png',
            ],
          ),
          const SizedBox(width: 4),
          AppPromoCarousel(
            fit: BoxFit.contain,
            alignment: Alignment.centerLeft,
            width: 300,
            height: 127,
            banners: const [
              'assets/images/porco_eats_images/carousel_images/firstcupomcarousel.png',
              'assets/images/porco_eats_images/carousel_images/secoundcupomcarousel.png',
            ],
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
