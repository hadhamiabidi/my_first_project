
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pfe/views/dashboard_page.dart';
import 'package:pfe/views/signup_page.dart';
import 'package:pfe/views/buttom_navigation_page.dart';
import 'package:pfe/controllers/buttom_navigation_controller.dart';



class LoginController extends GetxController {
  late TextEditingController emailField, passwordField;


  @override
  void onInit() {
    super.onInit();
    emailField = TextEditingController();
    passwordField = TextEditingController();
  }

  goToRegister() {
    Get.to(SignupPage());
  }


  void handeSignIn(context) {
    Get.to(ButtomNavigation());
  }

  void goToForgotPassword() {}

}







