
import 'package:get/get.dart';
import 'package:pfe/views/signup_page.dart';

import '../views/dashboard_page.dart';

class LoginController extends GetxController {

  goToRegister(){
    Get.to(SignupPage());
  }

  goToDashboard(){
    Get.to(DashboardPage());
  }
}