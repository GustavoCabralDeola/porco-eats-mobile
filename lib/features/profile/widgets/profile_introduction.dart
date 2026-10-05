import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:porco_eats/features/profile/widgets/profile_avatar.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';

class ProfileIntroduction extends StatelessWidget {
  const ProfileIntroduction({
    super.key,
    required this.initials,
    required this.onBack,
    required this.onEditPhoto,
    this.imageBytes,
    this.isPickingPhoto = false,
  });

  final String initials;
  final Uint8List? imageBytes;
  final VoidCallback onBack;
  final VoidCallback onEditPhoto;
  final bool isPickingPhoto;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back_ios),
              color: AppColors.darkBrown,
            ),
            const SizedBox(width: 2),
            const Text(
              'Seu perfil',
              style: TextStyle(
                color: AppColors.darkBrown,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text(
              'Mantenha seus dados atualizados para receber seus pedidos.',
              style: TextStyle(color: AppColors.subTitle, fontSize: 13),
            ),
          ),
        ),
        const SizedBox(height: 22),
        Stack(
          alignment: Alignment.center,
          children: [
            ProfileAvatar(
              initials: initials,
              imageBytes: imageBytes,
              onEditPressed: onEditPhoto,
            ),
            if (isPickingPhoto)
              const SizedBox(
                width: 26,
                height: 26,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
          ],
        ),
      ],
    );
  }
}
