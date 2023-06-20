
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pfe/config/base_controller.dart';
import 'package:pfe/routes/app_routes.dart';
import 'package:pfe/views/dashboard_page.dart';
import 'package:pfe/views/signup_page.dart';
import 'package:pfe/views/navigation_bar_page.dart';
import 'package:pfe/controllers/bottom_navigation_controller.dart';

import '../models/user.dart';



class SigninController extends GetxController with BaseController {
  late TextEditingController emailField, passwordField;
  final Rx<UserModel> user = UserModel.empty().obs;


  @override
  void onInit() {
    super.onInit();
    emailField = TextEditingController();
    passwordField = TextEditingController();
  }

  goToRegister() {
    Get.to(SignupPage());
  }


  void handeSignIn() async {
    if (emailField.text.isEmpty || passwordField.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter both email and password',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (!GetUtils.isEmail(emailField.text)) {
      Get.snackbar(
        'Error',
        'Please enter a valid email',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      showLoading();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailField.text.toString(),
        password: passwordField.text.toString(),
      );
      hideLoading();

      // Check if user is a driver
      final currentUser = FirebaseAuth.instance.currentUser;
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(currentUser!.uid).get();
      final userData = userDoc.data()!;
      final isDriver = userData['isDriver'];
      print(userData);
      final userObj = UserModel.fromJson({
        'uid': currentUser.uid,
        'email': currentUser.email,
        'firstName ': userData['firstName'],
        'lastName ': userData['lastName'],
        'isDriver': isDriver,
      });
      user.value = userObj;
      if(currentUser.email=="admin@admin.com"){
        Get.offAllNamed(AppRoutes.admin);
      }else{
        if (isDriver) {
          Get.offAllNamed(AppRoutes.bottomNavigation);
        } else {
          Get.offAllNamed(AppRoutes.dashboard);
        }
      }

    } on FirebaseAuthException catch (e) {
      hideLoading();
      if (e.code == 'user-not-found') {
        Get.snackbar(
          'Error',
          'No user found for that email.',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          'Error',
          'Wrong password provided for that user.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      hideLoading();
      print("ERROR");
      print(e);
      Get.snackbar(
        'Error',
        'Failed to sign in',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void goToForgotPassword() {
    Get.toNamed(AppRoutes.forgetPassword);
  }

}







