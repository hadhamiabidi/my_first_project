import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../controllers/buttom_navigation_controller.dart';
import '../utils/color_constants.dart';



class ButtomNavigation extends StatelessWidget {
  ButtomNavigation({super.key});

  final ButtomNavigationController _buttomNavigationControllerController =
  Get.find<ButtomNavigationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bottom AppBar Example",
          style: Theme.of(context).textTheme.subtitle1,
        ),
        centerTitle: true,
        actions: [
          Obx(
                () => Switch.adaptive(
              value: _buttomNavigationController.isDarkTheme.value,
              onChanged: (newVal) {
                _buttomNavigationController.isDarkTheme.value = newVal;
                _buttomNavigationController
                    .switchTheme(newVal ? ThemeMode.dark : ThemeMode.light);
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        notchMargin: 10,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
          child: Obx(
                () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _bottomAppBarItem(
                  icon: IconlyLight.home,
                  page: 0,
                  context,
                  label: "Chat",
                ),
                _bottomAppBarItem(
                    icon: IconlyLight.wallet,
                    page: 1,
                    context,
                    label: "All Orders"),
                _bottomAppBarItem(
                    icon: IconlyLight.chart,
                    page: 2,
                    context,
                    label: "My Order"),
                _bottomAppBarItem(
                    icon: IconlyLight.profile,
                    page: 3,
                    context,
                    label: "Profil"),
              ],
            ),
          ),
        ),
      ),
      body: PageView(
        controller: _buttomNavigationController.pageController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: _buttomNavigationController.animateToTab,
        children: [..._buttomNavigationController.pages],
      ),
    );
  }

  Widget _bottomAppBarItem(BuildContext context,
      {required icon, required page, required label}) {
    return ZoomTapAnimation(
      onTap: () => _buttomNavigationController.goToTab(page),
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: _buttomNavigationController.currentPage == page
                  ? ColorConstants.appColors
                  : Colors.grey,
              size: 20,
            ),
            Text(
              label,
              style: TextStyle(
                  color: _buttomNavigationController.currentPage == page
                      ? ColorConstants.appColors
                      : Colors.grey,
                  fontSize: 13,
                  fontWeight: _buttomNavigationController.currentPage == page
                      ? FontWeight.w600
                      : null),
            ),
          ],
        ),
      ),
    );
  }
}







