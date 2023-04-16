import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe/views/chat_page.dart';
import 'package:pfe/views/buttom_navigation_page.dart';
import 'package:pfe/views/my_order_page.dart';

import '../views/all_order_page.dart';
import '../views/profil_page.dart';





class ButtomNavigationController extends GetxController {
  late PageController pageController;



  RxInt currentPage = 0.obs;
  RxBool isDarkTheme = false.obs;

  List<Widget> pages = [
    const AllOrder(),
    const Chat(),
    const MyOrder(),
    const Profil(),
  ];

  ThemeMode get theme => Get.isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void switchTheme(ThemeMode mode) {
    Get.changeThemeMode(mode);
  }

  void goToTab(int page) {
    currentPage.value = page;
    pageController.jumpToPage(page);
  }
  void animateToTab(int page) {
    currentPage.value = page;
    pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease);
  }

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}