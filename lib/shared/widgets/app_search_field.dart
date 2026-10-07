import 'package:flutter/material.dart';
import 'package:porco_eats/features/home/controllers/home_search_filter_controller.dart';
import 'package:porco_eats/shared/widgets/app_colors.dart';
import 'package:porco_eats/shared/widgets/app_search_button.dart';
import 'package:provider/provider.dart';

class AppSearchField extends StatefulWidget {
  const AppSearchField({
    super.key,
    required this.hintText,
    this.enableFilter = false,
  });

  final String hintText;
  final bool? enableFilter;

  @override
  State<AppSearchField> createState() => _AppSearchFieldState();
}

class _AppSearchFieldState extends State<AppSearchField> {
  late final TextEditingController _textController;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialized) return;
    _textController.text = context
        .read<HomeSearchFilterController>()
        .searchText;
    _initialized = true;
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _textController,
              keyboardType: TextInputType.webSearch,
              onChanged: context
                  .read<HomeSearchFilterController>()
                  .setSearchText,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  color: AppColors.subTitle,
                  fontSize: 14,
                ),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: ListenableBuilder(
                  listenable: _textController,
                  builder: (context, child) => _textController.text.isEmpty
                      ? const SizedBox.shrink()
                      : IconButton(
                          tooltip: 'Limpar busca',
                          onPressed: () {
                            _textController.clear();
                            context
                                .read<HomeSearchFilterController>()
                                .setSearchText('');
                          },
                          icon: const Icon(Icons.close),
                        ),
                ),
                fillColor: AppColors.fullWhite,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: AppColors.borderInputColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                  borderSide: const BorderSide(
                    color: Colors.black87,
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
          if (widget.enableFilter == true) ...[
            const SizedBox(width: 5),
            const AppSearchButton(),
          ],
        ],
      ),
    );
  }
}
