import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/base_controller.dart';

class SettingsController extends GetxController with BaseController {
  final RxBool isCurrentPasswordVisible = false.obs;

  void toggleCurrentPasswordVisibility() {
    print("toggleCurrentPasswordVisibility");
    isCurrentPasswordVisible.toggle();
  }


  final TextEditingController currentPasswordController =
  TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  void changePassword() async {
    String currentPassword = currentPasswordController.text;
    String newPassword = newPasswordController.text;

    try {
      showLoading();
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: FirebaseAuth.instance.currentUser!.email!,
        password: currentPassword,
      );

      if (userCredential.user != null) {
        await userCredential.user!.updatePassword(newPassword);
        hideLoading();
        showDialog(
          context: Get.context!,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Mot de passe modifié'),
              content: Text('Votre mot de passe a été modifié avec succès.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      hideLoading();
      showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erreur'),
            content: Text(
                'Une erreur s\'est produite lors de la modification du mot de passe.'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    super.onClose();
  }
}