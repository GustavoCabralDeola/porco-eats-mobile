import 'package:flutter/material.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:porco_eats/shared/widgets/app_text_form_field_notifier.dart';
 
class AppTextFormField extends StatefulWidget {
  const AppTextFormField(
    this.keyboardType, {
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.onChanged,
    this.textEditingcontroller,
    this.onSubmitted,
    this.prefixIcon,
    this.validator,
  });
 
  final String hintText;
  final bool obscureText;
 
  final IconData? prefixIcon;
  final IconData? suffixIcon;
 
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextEditingController? textEditingcontroller;
  final String? Function(String?)? validator;
 
  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}
 
class _AppTextFormFieldState extends State<AppTextFormField> {
  late final AppTextFormFieldNotifier notifier;
 
  @override
  void initState() {
    super.initState();
    notifier = AppTextFormFieldNotifier(widget.obscureText);
  }
 
  @override
  void didUpdateWidget(covariant AppTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
 
    if (oldWidget.obscureText != widget.obscureText) {
      notifier.setObscure(widget.obscureText);
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: notifier,
      builder: (context, child) {
        return TextFormField(
          controller: widget.textEditingcontroller,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          onChanged: widget.onChanged,
          autovalidateMode: AutovalidateMode.onUnfocus,
          obscureText: notifier.isObscure,
          decoration: InputDecoration(
            hintText: widget.hintText,
            filled: true,
            fillColor: AppColors.fullWhite,
 
            contentPadding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 15,
            ),
 
            prefixIcon: _buildPrefixIcon(),
            suffixIcon: _buildSuffixIcon(),
 
            enabledBorder: _buildBorder(AppColors.borderInputColor),
 
            focusedBorder: _buildBorder(Colors.black87, width: 1.5),
 
            errorBorder: _buildBorder(AppColors.redDelivery),
 
            focusedErrorBorder: _buildBorder(AppColors.redDelivery, width: 1.5),
          ),
        );
      },
    );
  }
 
  Widget? _buildPrefixIcon() {
    if (widget.prefixIcon == null) return null;
 
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 12),
      child: Icon(widget.prefixIcon, color: AppColors.darkBrown),
    );
  }
 
  Widget? _buildSuffixIcon() {
    if (widget.obscureText) {
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
 
    if (widget.suffixIcon == null) return null;
 
    return Icon(widget.suffixIcon, color: AppColors.darkBrown);
  }
 
  OutlineInputBorder _buildBorder(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(28),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
 