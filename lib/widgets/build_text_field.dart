import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildTextField({
  required String hintText,
  required IconData prefixIcon,
  required TextEditingController controller,
  bool obscureText = false,
}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      fillColor: Theme.of(Get.context!).primaryColor.withOpacity(0.1),
      filled: true,
      prefixIcon: Icon(prefixIcon),
    ),
    obscureText: obscureText,
  );
}
