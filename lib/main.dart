import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pfe/bindings/onboarding_binding.dart';
import 'package:pfe/routes/app_pages.dart';

import 'package:pfe/views/onboarding_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      initialBinding: OnBoardingBinding(),
      home: OnboardingPage(),
      getPages: AppPages.pages,
    );
  }

}

