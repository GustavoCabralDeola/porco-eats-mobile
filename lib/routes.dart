import 'package:flutter/cupertino.dart';
import 'package:porco_eats/features/home/pages/home_page.dart';
import 'package:porco_eats/features/login/pages/login_page.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    LoginPage.route: (context) => LoginPage(),
    HomePage.route: (context) => HomePage(),
  };
}
