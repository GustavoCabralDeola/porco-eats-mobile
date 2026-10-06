import 'package:flutter/material.dart';
import 'package:porco_eats/shared/widgets/cards/app_store_card.dart';
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
              return AppStoreCard(
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
