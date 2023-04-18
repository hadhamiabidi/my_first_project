import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:pfe/bindings/bottom_navigation_binding.dart';
import 'package:pfe/bindings/claim_binding.dart';
import 'package:pfe/bindings/login_binding.dart';
import 'package:pfe/bindings/onboarding_binding.dart';
import 'package:pfe/bindings/order_details_binding.dart';
import 'package:pfe/bindings/orders_binding.dart';
import 'package:pfe/controllers/bottom_navigation_controller.dart';
import 'package:pfe/views/claim_page.dart';
import 'package:pfe/views/dashboard_page.dart';
import 'package:pfe/views/login_page.dart';
import 'package:pfe/views/order_details_page.dart';
import 'package:pfe/views/orders_page.dart';
import '../bindings/dashboard_binding.dart';
import '../views/navigation_bar_page.dart';
import '../views/onboarding_page.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.onBoarding,
      page: () =>  OnboardingPage(),
      binding: OnBoardingBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () =>  LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () =>  DashboardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.orders,
      page: () =>  OrdersPage(),
      binding: OrdersBinding(),
    ),
    GetPage(
      name: AppRoutes.claims,
      page: () =>  ClaimsPage(),
      binding: ClaimsBinding(),
    ),
    GetPage(
      name: AppRoutes.order,
      page: () =>  OrderDetailsPage(),
      binding: OrderDetailsBinding(),
    ),
    GetPage(
      name: AppRoutes.bottomNavigation,
      page: () =>  NavigationPage(),
      binding: BottomNavigation(),
    ),
  ];
}