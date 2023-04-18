import 'package:get/get.dart';
import 'package:pfe/controllers/bottom_navigation_controller.dart';


class BottomNavigation extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomNavigationController());
  }
}