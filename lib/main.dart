import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pfe/bindings/login_binding.dart';
import 'package:pfe/bindings/onboarding_binding.dart';
import 'package:pfe/bindings/signup_binding.dart';
import 'package:pfe/firebase_options.dart';
import 'package:pfe/routes/app_pages.dart';
import 'package:pfe/views/login_page.dart';

import 'package:pfe/views/onboarding_page.dart';
import 'package:pfe/views/signup_page.dart';


void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      initialBinding:SignInBinding(),
      home: SigninPage(),
      getPages: AppPages.pages,
    );
  }

}

