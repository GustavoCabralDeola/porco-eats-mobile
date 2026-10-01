import 'package:flutter/material.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';

class AppTextFormField extends StatefulWidget {
  const AppTextFormField(
    this.keyboardType, {
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.onChanged,
    this.textEditingcontroller,
    this.prefixIcon,
    this.onSubmitted,
    this.validator,
  });

  final String hintText;
  final bool obscureText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final TextEditingController? textEditingcontroller;
  final Function(String)? onSubmitted;
  final FormFieldValidator<String>? validator;

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  late bool isObscure;
  @override
  void initState() {
    super.initState();
    isObscure = widget.obscureText;
  }

  void toggleObscure() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      controller: widget.textEditingcontroller,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUnfocus,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon != null
            ? Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 12.0),
                child: Icon(widget.prefixIcon, color: AppColors.darkBrown),
              )
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
      ),
    );
  }
}
