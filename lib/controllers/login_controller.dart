
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pfe/views/dashboard_page.dart';
import 'package:pfe/views/signup_page.dart';

class LoginController extends GetxController {
  late TextEditingController emailField, passwordField;


  @override
  void onInit() {
    super.onInit();
    emailField = TextEditingController();
    passwordField = TextEditingController();

  }

  goToRegister(){
    Get.to(SignupPage());
  }


  void handeSignIn(context) {
    Get.to(DashboardPage());
  }

  void goToForgotPassword() {}
}