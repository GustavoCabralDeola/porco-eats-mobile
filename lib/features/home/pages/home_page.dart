import 'package:flutter/material.dart';
import 'package:porco_eats/features/home/controllers/home_controller.dart';
import 'package:porco_eats/shared/widgets/app_search_field.dart';
import 'package:provider/provider.dart';

import '../../../shared/widgets/app_home_header.dart';

class HomePage extends StatelessWidget {
  static String route = '/home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer<HomeController>(
          builder: (context, controller, child) => Column(
            children: [
              AppHomeHeader(),
              SizedBox(height: 10),
              AppSearchField(
                hintText: 'O que você deseja comer hoje?',
                enableFilter: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
