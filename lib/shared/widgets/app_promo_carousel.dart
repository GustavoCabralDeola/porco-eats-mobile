import 'package:flutter/material.dart';
import 'package:porco_eats/features/home/controllers/promo_carousel_controller.dart';
import 'package:provider/provider.dart';

class AppPromoCarousel extends StatelessWidget {
  final List<String> banners;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final double width;
  final double height;

  const AppPromoCarousel({
    super.key,
    required this.banners,
    this.fit = BoxFit.fill,
    this.alignment = Alignment.center,
    this.width = 255,
    this.height = 125,
  });

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
            width: width,
            height: height,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: PageView.builder(
                    controller: controller.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: controller.updatePage,
                    itemCount: banners.length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        banners[index],
                        fit: fit,
                        alignment: alignment,
                      );
                    },
                  ),
                ),

                Positioned(
                  bottom: 8,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      banners.length,
                      (index) => GestureDetector(
                        onTap: () => controller.goToPage(index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: 9,
                          height: 9,
                          decoration: BoxDecoration(
                            color: controller.currentPage == index
                                ? const Color(0xFFFFC107)
                                : const Color(0xFF9E9E9E),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 1.5),
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
