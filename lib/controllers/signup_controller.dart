import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  late TextEditingController nomField,prenomField,passwordField,EmailField,numField,confirmField;

  @override
  void onInit() {
    super.onInit();
    nomField = TextEditingController();
    prenomField = TextEditingController();
    passwordField = TextEditingController();
    EmailField = TextEditingController();
    numField = TextEditingController();
    confirmField = TextEditingController();
  }
}