import 'package:flutter/material.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';

class ProfileSaveButton extends StatelessWidget {
  const ProfileSaveButton({
    super.key,
    required this.isSaving,
    required this.onPressed,
  });

  final bool isSaving;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isSaving ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.yellowAgility,
          foregroundColor: AppColors.darkBrown,
          minimumSize: const Size(0, 54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: isSaving
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Text(
                'Salvar meus dados',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
      ),
    );
  }
}
