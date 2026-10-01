import 'package:flutter/material.dart';
import 'package:porco_eats/features/home/controllers/home_controller.dart';
import 'package:porco_eats/features/login/controllers/login_controller.dart';
import 'package:porco_eats/features/login/pages/login_page.dart';
import 'package:porco_eats/features/login/pages/signup_page.dart'
    show SignupPage;
import 'package:porco_eats/features/splash/pages/splash_screen_page.dart';
import 'package:porco_eats/models/user.dart';
import 'package:porco_eats/routes.dart';
import 'package:porco_eats/shared/services/app_remember_me.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = AppPreferences();
  final rememberedUser = await preferences.loadUser();
  runApp(MyApp(preferences: preferences, rememberedUser: rememberedUser));
}

class MyApp extends StatelessWidget {
  final AppPreferences preferences;
  final User? rememberedUser;

  const MyApp({
    super.key,
    required this.preferences,
    required this.rememberedUser,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginController(
            preferences: preferences,
            rememberedUser: rememberedUser,
          ),
        ),
        ChangeNotifierProvider(
          create: (context) {
            return HomeController();
          },
        ),
      ],
      child: MaterialApp(
        home: SplashScreen(hasRememberedUser: rememberedUser != null),
        routes: AppRoutes.routes,
      ),
    );
  }
}
