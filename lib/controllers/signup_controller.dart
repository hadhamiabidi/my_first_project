import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pfe/config/base_controller.dart';
import 'package:pfe/routes/app_routes.dart';

import '../views/dashboard_page.dart';

class SignupController extends GetxController with BaseController {
  late TextEditingController nomField,prenomField,passwordField,emailField,numField,confirmField;
  final isDriver = false.obs;

  @override
  void onInit() {
    super.onInit();
    nomField = TextEditingController();
    prenomField = TextEditingController();
    passwordField = TextEditingController();
    emailField = TextEditingController();
    numField = TextEditingController();
    confirmField = TextEditingController();
  }

  Future<void> handeSignUp(BuildContext context) async {
    if (nomField.text.isEmpty) {
      Get.snackbar("Error", "Please enter your name",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (prenomField.text.isEmpty) {
      Get.snackbar("Error", "Please enter your last name",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (!GetUtils.isEmail(emailField.text)) {
      Get.snackbar("Error", "Please enter a valid email address",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (passwordField.text.isEmpty || passwordField.text.length < 6) {
      Get.snackbar(
          "Error", "Please enter a password with at least 6 characters",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (confirmField.text != passwordField.text) {
      Get.snackbar("Error", "Passwords do not match",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (!GetUtils.isPhoneNumber(numField.text)) {
      Get.snackbar("Error", "Please enter a valid phone number",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    try {
      // Create a new user in Firebase Auth
      showLoading();
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailField.text,
        password: passwordField.text,
      );

      // Add a new user document to the "users" collection
      await FirebaseFirestore.instance.collection("users").doc(userCredential.user!.uid).set({
        "firstName": prenomField.text,
        "lastName": nomField.text,
        "email": emailField.text,
        "phone": numField.text,
        "isDriver":isDriver
      });
      hideLoading();
      // Show a success message
      Get.snackbar("Success", "User created successfully",
          snackPosition: SnackPosition.BOTTOM);
      Get.toNamed(AppRoutes.dashboard);
      // Navigate to the home page or the next screen
      // ...
    } on FirebaseAuthException catch (e) {
      hideLoading();
      Get.snackbar("Error", e.message!, snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      hideLoading();
      // Show an error message
      Get.snackbar(
          "Error", "Failed to create user. Please try again later.",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

}

