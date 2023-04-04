import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:get/utils.dart';
import '../models/onboarding_info.dart';
import '../views/login_page.dart';

class OnboardingController extends GetxController {
  var selectedPageIndex = 0.obs;
  bool get isLastPage => selectedPageIndex.value == onboardingPages.length - 1;
  var pageController = PageController();

  forwardAction() {
    if (isLastPage) {
      //go to home page  utiliser getX pour naviguer de ecran a un autre
     Get.to(LoginPage());


    } else {
      pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
    }
  }
  List<OnboardingInfo> onboardingPages = [
    OnboardingInfo('assets/order.jpg', 'Place Your Order', 'Now you can order any time right from your mobile.'),
    OnboardingInfo('assets/quick delivery.jpg', 'Quick Delivery', 'Orders will be immediately deliver'),
    OnboardingInfo('assets/paiement.jpg', 'payment', 'You can pay with different methods'),
  ];
}