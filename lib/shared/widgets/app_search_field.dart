import 'package:flutter/material.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:porco_eats/shared/widgets/app_search_button.dart';

class AppSearchField extends StatelessWidget {
  const AppSearchField({
    super.key,
    required this.hintText,
    this.enableFilter = false,
    this.controller,
    this.onChanged,
    this.onFilterPressed,
  });

  final String hintText;
  final bool? enableFilter;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onFilterPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.webSearch,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: AppColors.subTitle, fontSize: 14),
                prefixIcon: Icon(Icons.search),
                fillColor: AppColors.fullWhite,
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: AppColors.borderInputColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                  borderSide: BorderSide(color: Colors.black87, width: 1.5),
                ),
              ),
            ),
          ),

          if (enableFilter == true) ...[
            const SizedBox(width: 5),
            AppSearchButton(onPressed: onFilterPressed),
          ],
        ],
      ),
    );
  }
}
