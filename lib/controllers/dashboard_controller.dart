import 'package:get/get.dart';
import 'package:pfe/routes/app_routes.dart';

class DashboardController extends GetxController {
  void goToPage(int index) {
    switch (index) {
      case 1:
        Get.toNamed(AppRoutes.orders);
        break;
      case 4:
        Get.toNamed(AppRoutes.claims);
        break;
      case 5:
        Get.toNamed(AppRoutes.conversations);
        break;
      default:
      // Do nothing
        break;
    }
  }


}