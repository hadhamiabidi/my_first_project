import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe/config/base_controller.dart';
import 'package:pfe/routes/app_routes.dart';

class ForgetPasswordController extends GetxController with BaseController {
  late TextEditingController emailField;


  @override
  void onInit() {
    super.onInit();
    emailField = TextEditingController();
  }

  void handleForgetPassword() async {
    final String email = emailField.text.trim();
    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Error', 'Please enter a valid email address',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    showLoading();
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      hideLoading();
      Get.snackbar('Success', 'Password reset email sent',
          snackPosition: SnackPosition.BOTTOM);
      Get.offAllNamed(AppRoutes.login);
    } on FirebaseAuthException catch (e) {
      hideLoading();
      if (e.code == 'user-not-found') {
        Get.snackbar('Error', 'No user found for that email address',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Error', 'Failed to send password reset email',
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

}