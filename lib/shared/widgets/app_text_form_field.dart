import 'package:flutter/material.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:porco_eats/shared/widgets/app_text_form_field_notifier.dart';

class AppTextFormField extends StatelessWidget {
  AppTextFormField(
    this.keyboardType, {
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.onChanged,
    this.textEditingController,
    this.prefixIcon,
    this.validator,
  }) : notifier = AppTextFormFieldNotifier(obscureText);

  final String hintText;
  final bool obscureText;

  final IconData? prefixIcon;
  final IconData? suffixIcon;

  final TextInputType? keyboardType;

  final ValueChanged<String>? onChanged;
  final TextEditingController? textEditingController;
  final String? Function(String?)? validator;

  final AppTextFormFieldNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: notifier,
      builder: (context, child) {
        return TextFormField(
          controller: textEditingController,
          keyboardType: keyboardType,
          validator: validator,
          onChanged: onChanged,
          autovalidateMode: AutovalidateMode.onUnfocus,
          obscureText: notifier.isObscure,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: AppColors.fullWhite,

            contentPadding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 20,
            ),

            prefixIcon: _buildPrefixIcon(),
            suffixIcon: _buildSuffixIcon(),

            enabledBorder: _buildBorder(
              AppColors.borderInputColor,
            ),

            focusedBorder: _buildBorder(
              Colors.black87,
              width: 1.5,
            ),

            errorBorder: _buildBorder(
              AppColors.redDelivery,
            ),

            focusedErrorBorder: _buildBorder(
              AppColors.redDelivery,
              width: 1.5,
            ),
          ),
        );
      },
    );
  }

  Widget? _buildPrefixIcon() {
    if (prefixIcon == null) return null;

    return Padding(
      padding: const EdgeInsets.only(
        left: 24,
        right: 12,
      ),
      child: Icon(
        prefixIcon,
        color: AppColors.darkBrown,
      ),
    );
  }

  Widget? _buildSuffixIcon() {
    if (obscureText) {
      return IconButton(
        onPressed: notifier.toggleObscure,
        icon: Icon(
          notifier.isObscure
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          color: AppColors.darkBrown,
        ),
      );
    }

    if (suffixIcon == null) return null;

    return Icon(
      suffixIcon,
      color: AppColors.darkBrown,
    );
  }

  OutlineInputBorder _buildBorder(
    Color color, {
    double width = 1,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
    );
  }
}
