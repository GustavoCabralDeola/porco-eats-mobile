import 'package:flutter/material.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:porco_eats/shared/widgets/app_text_style.dart';

class RecommendedStoresSection extends StatelessWidget {
  const RecommendedStoresSection({
    super.key,
    required this.stores,
    required this.onStoreTap,
  });

  final List<String> stores;
  final ValueChanged<String> onStoreTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text('Lojas para conhecer', style: AppTextStyle.sectionTitle),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 112,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: stores.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final store = stores[index];
              return _StoreCard(
                name: store,
                onTap: () => onStoreTap(store),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _StoreCard extends StatelessWidget {
  const _StoreCard({required this.name, required this.onTap});

  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 190,
      child: Material(
        color: AppColors.fullWhite,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderInputColor),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.categoryBackground,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.storefront_outlined,
                    color: AppColors.darkBrown,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.darkBrown,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Ver produtos',
                        style: TextStyle(
                          color: AppColors.subTitle,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
