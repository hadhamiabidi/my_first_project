import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:pfe/bindings/login_binding.dart';
import 'package:pfe/bindings/onboarding_binding.dart';
import 'package:pfe/views/dashboard_page.dart';
import 'package:pfe/views/login_page.dart';
import '../bindings/dashboard_binding.dart';
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
  ];
}