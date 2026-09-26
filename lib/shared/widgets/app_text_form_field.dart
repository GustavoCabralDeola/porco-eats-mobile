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
    this.textEditingcontroller,
    this.prefixIcon,
    this.validator,
  }) : notifier = AppTextFormFieldNotifier(obscureText);

  final String hintText;
  final bool obscureText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final TextEditingController? textEditingcontroller;
  final String? Function(String?)? validator;
  final AppTextFormFieldNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: notifier,
      builder: (context, child) {
        return TextFormField(
          keyboardType: keyboardType,
          controller: textEditingcontroller,
          autovalidateMode: AutovalidateMode.onUnfocus,
          validator: validator,
          onChanged: onChanged,
          obscureText: notifier.isObscure,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 24.0, right: 12.0),
                    child: Icon(prefixIcon, color: AppColors.darkBrown),
                  )
                : null,

            suffixIcon: obscureText
                ? IconButton(
                    onPressed: notifier.toggleObscure,
                    icon: Icon(
                      notifier.isObscure
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.darkBrown,
                    ),
                  )
                : suffixIcon != null
                ? Icon(suffixIcon, color: AppColors.darkBrown)
                : null,
            filled: true,
            fillColor: AppColors.fullWhite,
            contentPadding: EdgeInsets.symmetric(vertical: 18),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: BorderSide(color: AppColors.borderInputColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: BorderSide(color: Colors.black87, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: BorderSide(color: AppColors.redDelivery),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(28),
              borderSide: BorderSide(color: AppColors.redDelivery, width: 1.5),
            ),
          ),
        );
      },
    );
  }
}
