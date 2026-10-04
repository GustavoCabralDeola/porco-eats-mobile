import 'package:flutter/cupertino.dart';
import 'package:porco_eats/features/cart/pages/cart_page.dart';
import 'package:porco_eats/features/home/pages/home_page.dart';
import 'package:porco_eats/features/login/pages/login_page.dart';
import 'package:porco_eats/features/login/pages/signup_page.dart';
import 'package:porco_eats/features/recover/pages/recover_page.dart';
import 'package:porco_eats/features/payment/pages/payment_page.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    LoginPage.route: (context) => LoginPage(),
    HomePage.route: (context) => HomePage(),
    RecoverPage.route: (context) => RecoverPage(),
    SignupPage.route: (context) => SignupPage(),
    CartPage.route: (context) => CartPage(),
    PaymentPage.route: (context) => const PaymentPage(),
  };
}
