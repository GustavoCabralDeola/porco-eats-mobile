import 'package:flutter/material.dart';
import 'package:porco_eats/shared/widgets/app_text_style.dart';

class AppIntroText extends StatelessWidget {
  const AppIntroText({super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: AppTextStyle.title, textAlign: TextAlign.center),
        const SizedBox(height: 10),
        Text(
          subtitle,
          style: AppTextStyle.subTitle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
