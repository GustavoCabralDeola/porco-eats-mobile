import 'package:flutter/material.dart';
import 'package:porco_eats/features/cart/controllers/cart_controller.dart';
import 'package:porco_eats/features/home/controllers/home_controller.dart';
import 'package:porco_eats/features/login/controllers/login_controller.dart';
import 'package:porco_eats/features/login/controllers/signup_controller.dart';
import 'package:porco_eats/features/login/pages/login_page.dart';
import 'package:porco_eats/features/order_list/controllers/orders_list_controller.dart';
import 'package:porco_eats/features/payment/controllers/payment_controller.dart';
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
  const MyApp({
    super.key,
    required this.preferences,
    this.rememberedUser,
  });

  final AppPreferences preferences;
  final User? rememberedUser;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return LoginController(
              preferences: preferences,
              rememberedUser: rememberedUser,
            );
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return SignupController(preferences: preferences);
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return HomeController();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return OrderListController();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return CartController();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return PaymentController();
          },
        ),
      ],
      builder: (context, child) {
        return MaterialApp(
          routes: AppRoutes.routes,
          initialRoute: LoginPage.route,
        );
      },
    );
  }
}
