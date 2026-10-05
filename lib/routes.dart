import 'package:flutter/cupertino.dart';
import 'package:porco_eats/features/Dashboard/pages/dashboard_order_page.dart';
import 'package:porco_eats/features/cart/pages/cart_page.dart';
import 'package:porco_eats/features/customer_order/pages/customer_order_page.dart';
import 'package:porco_eats/features/order_list/pages/order_details_page.dart';
import 'package:porco_eats/features/home/pages/home_page.dart';
import 'package:porco_eats/features/login/pages/login_page.dart';
import 'package:porco_eats/features/login/pages/signup_page.dart';
import 'package:porco_eats/features/order_list/pages/orders_list_page.dart';
import 'package:porco_eats/features/profile/pages/profile_page.dart';
import 'package:porco_eats/features/recover/pages/recover_page.dart';
import 'package:porco_eats/features/payment/pages/payment_page.dart';
import 'package:porco_eats/models/customer_order.dart';
import 'package:provider/provider.dart';

class AppRoutes {
  static final Map<String, WidgetBuilder> routes = {
    LoginPage.route: (context) => LoginPage(),
    HomePage.route: (context) => HomePage(),
    RecoverPage.route: (context) => RecoverPage(),
    SignupPage.route: (context) => SignupPage(),
    CartPage.route: (context) => CartPage(),
    PaymentPage.route: (context) => PaymentPage(),
    OrdersPage.route: (context) => OrdersPage(),
    CustomerOrderPage.route: (context) => CustomerOrderPage(),
    OrderDetailsPage.route: (context) =>
        OrderDetailsPage(customerOrder: context.read<CustomerOrder>()),
    DashboardOrderPage.route: (context) => DashboardOrderPage(),

    ProfilePage.route: (context) => ProfilePage(),
  };
}
