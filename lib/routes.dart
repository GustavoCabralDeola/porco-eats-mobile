import 'package:flutter/cupertino.dart';
import 'package:porco_eats/features/login/pages/login_page.dart';
import 'package:porco_eats/features/recover/pages/recover_page.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    LoginPage.route: (context) => LoginPage(),
    RecoverPage.route: (context) => RecoverPage(),
  };
}
