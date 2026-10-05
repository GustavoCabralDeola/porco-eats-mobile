import 'package:flutter/material.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';

class AppProductImage extends StatelessWidget {
  const AppProductImage({
    required this.imageUrl,
    this.fit = BoxFit.cover,
    super.key,
  });

  final String imageUrl;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final uri = Uri.tryParse(imageUrl);
    final isNetworkImage =
        uri != null &&
        (uri.scheme.toLowerCase() == 'http' ||
            uri.scheme.toLowerCase() == 'https');

    if (imageUrl.trim().isEmpty) return _placeholder();

    return isNetworkImage
        ? Image.network(
            imageUrl,
            fit: fit,
            errorBuilder: (_, _, _) => _placeholder(),
          )
        : Image.asset(
            imageUrl,
            fit: fit,
            errorBuilder: (_, _, _) => _placeholder(),
          );
  }

  Widget _placeholder() {
    return const ColoredBox(
      color: AppColors.brownWhite,
      child: Center(
        child: Icon(Icons.fastfood_outlined, color: AppColors.darkBrown),
      ),
    );
  }
}
