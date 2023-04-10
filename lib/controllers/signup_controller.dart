import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  late TextEditingController nomField,prenomField,passwordField,emailField,numField,confirmField;

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

  void handeSignUp(BuildContext context) {}
}