import 'package:get/get.dart';
import 'package:pfe/routes/app_routes.dart';

class DashboardController extends GetxController {
  void goToPage(int index) {
    if(index==1){
      Get.toNamed(AppRoutes.orders);
    }else if(index==4){
      Get.toNamed(AppRoutes.claims);
    }
  }

}