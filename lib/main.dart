import 'package:flutter/material.dart';
import 'package:porco_eats/features/home/controllers/home_controller.dart';
import 'package:porco_eats/features/login/controllers/login_controller.dart';
import 'package:porco_eats/features/splash/presentation/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginController(),
        ),
        ChangeNotifierProvider(
          create: (context) {
            return HomeController();
          },
        ),
      ],
      child: MaterialApp(
        home: const SplashScreen(),
      ),
    );
  }
}
