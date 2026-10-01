import 'package:flutter/material.dart';
import 'package:porco_eats/features/home/controllers/promo_carousel_controller.dart';
import 'package:provider/provider.dart';

class AppPromoCarousel extends StatelessWidget {
  final List<String> banners;

  const AppPromoCarousel({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final controller = PromoCarouselController();
        controller.initTimer(banners.length);
        return controller;
      },
      child: Consumer<PromoCarouselController>(
        builder: (context, controller, child) {
          return SizedBox(
            height: 190,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: PageView.builder(
                    controller: controller.pageController,
                    padEnds: false,
                    onPageChanged: controller.updatePage,
                    itemCount: banners.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(banners[index], fit: BoxFit.fill),
                        ),
                      );
                    },
                  ),
                ),

                Positioned(
                  bottom: 12,
                  left: 15,
                  right: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      banners.length,
                      (index) => GestureDetector(
                        onTap: () => controller.goToPage(index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),

                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                            color: controller.currentPage == index
                                ? const Color(0xFFFFC107)
                                : const Color(0xFF9E9E9E),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 2.5),
                          ),
                        ),
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
}
