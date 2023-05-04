import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:pfe/bindings/bottom_navigation_binding.dart';
import 'package:pfe/bindings/add_order_binding.dart';
import 'package:pfe/bindings/chat_binding.dart';
import 'package:pfe/bindings/claim_binding.dart';
import 'package:pfe/bindings/conversation_binding.dart';
import 'package:pfe/bindings/forget_password_binding.dart';
import 'package:pfe/bindings/login_binding.dart';
import 'package:pfe/bindings/my_order_binding.dart';
import 'package:pfe/bindings/onboarding_binding.dart';
import 'package:pfe/bindings/order_details_binding.dart';
import 'package:pfe/bindings/orders_binding.dart';
import 'package:pfe/bindings/signup_binding.dart';
import 'package:pfe/views/add_order_page.dart';
import 'package:pfe/views/chat_page.dart';
import 'package:pfe/views/claim_page.dart';
import 'package:pfe/views/conversation_page.dart';
import 'package:pfe/views/dashboard_page.dart';
import 'package:pfe/views/forget_password_page.dart';
import 'package:pfe/views/login_page.dart';
import 'package:pfe/views/my_order_page.dart';
import 'package:pfe/views/order_details_page.dart';
import 'package:pfe/views/orders_page.dart';
import 'package:pfe/views/profile_page.dart';
import 'package:pfe/views/signup_page.dart';
import '../bindings/dashboard_binding.dart';
import '../bindings/profile_binding.dart';
import '../views/all_orders_page.dart';
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
      page: () =>  SigninPage(),
      binding: SignInBinding(),
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
    GetPage(
      name: AppRoutes.allOrders,
      page: () =>  AllOrdersPage(),
      binding: OrdersBinding(),
    ),
    GetPage(
      name: AppRoutes.myOrder,
      page: () =>  MyOrderPage(),
      binding: MyOrderBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () =>  ProfilePage(),
      binding: Profile(),
    ),
    GetPage(
      name: AppRoutes.addOrder,
      page: () =>  AddOrderScreen(),
      binding: AddOrderBinding(),
    ),
    GetPage(
      name: AppRoutes.conversations,
      page: () =>  ConversationsPage(),
      binding: ConversationsBinding(),
    ),
    GetPage(
      name: AppRoutes.chat,
      page: () =>  ChatPage(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () =>  SignupPage(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: AppRoutes.forgetPassword,
      page: () =>  ForgetPasswordPage(),
      binding: ForgetPasswordBinding(),
    ),
  ];
}