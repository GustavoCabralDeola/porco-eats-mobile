import 'package:flutter/material.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:porco_eats/shared/widgets/app_text_form_field_notifier.dart';
import 'package:provider/provider.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField(
    this.keyboardType, {
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.onChanged,
    this.textEditingcontroller,
    this.onSubmitted,
    this.prefixIcon,
    this.validator,
    this.autofocus = false,
  });

  final String hintText;
  final bool obscureText;

  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;

  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextEditingController? textEditingcontroller;
  final String? Function(String?)? validator;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppTextFormFieldNotifier(obscureText),
      child: Consumer<AppTextFormFieldNotifier>(
        builder: (context, notifier, child) {
          return TextFormField(
            controller: textEditingcontroller,
            keyboardType: keyboardType,
            validator: validator,
            onChanged: onChanged,
            onFieldSubmitted: onSubmitted,
            autofocus: autofocus,
            autovalidateMode: AutovalidateMode.onUnfocus,
            obscureText: notifier.isObscure,
            decoration: InputDecoration(
              hintText: hintText,
              filled: true,
              fillColor: AppColors.fullWhite,

              contentPadding: const EdgeInsets.symmetric(
                vertical: 18,
                horizontal: 15,
              ),

              prefixIcon: _buildPrefixIcon(),
              suffixIcon: _buildSuffixIcon(notifier),

              enabledBorder: _buildBorder(AppColors.borderInputColor),

              focusedBorder: _buildBorder(Colors.black87, width: 1.5),

              errorBorder: _buildBorder(AppColors.redDelivery),

              focusedErrorBorder: _buildBorder(
                AppColors.redDelivery,
                width: 1.5,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget? _buildPrefixIcon() {
    if (prefixIcon == null) return null;

    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 12),
      child: Icon(prefixIcon, color: AppColors.darkBrown),
    );
  }

  Widget? _buildSuffixIcon(AppTextFormFieldNotifier notifier) {
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

    return IconButton(
      onPressed: onSuffixIconPressed,
      icon: Icon(suffixIcon, color: AppColors.darkBrown),
    );
  }

  OutlineInputBorder _buildBorder(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
