import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.heroTag,
  });

  final double? width;
  final double? height;
  final BoxFit fit;
  final String? heroTag;

  @override
  Widget build(BuildContext context) {
    final image = Image.asset(
      'assets/images/porco_eats_images/logoporcoeats.png',
      width: width,
      height: height,
      fit: fit,
    );

    if (heroTag == null || heroTag!.isEmpty) {
      return image;
    }

    return Hero(tag: heroTag!, child: image);
  }
}
