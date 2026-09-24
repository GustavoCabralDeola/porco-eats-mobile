import 'package:flutter/material.dart';
import 'package:porco_eats/shared/widgets/app_login_header.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static String route = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(backgroundColor: const Color(0xFF2D170B)),
      body: SingleChildScrollView(
        child: Column(children: [AppLoginHeader(), SizedBox(height: 20)]),
      ),
    );
  }
}
