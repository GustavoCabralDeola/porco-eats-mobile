import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static String route = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFF2D170B)),
      body: Container(
        width: double.infinity,
        color: const Color(0xFFF7F6F2),
        child: Column(
          children: [
            const SizedBox(height: 20),

            SizedBox(
              height: 50,
              child: Image.asset(
                'assets/images/porco_eats_images/logoporcoeats.png',
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
