import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:get/utils.dart';
import 'package:pfe/config/base_controller.dart';
import 'package:pfe/routes/app_routes.dart';
import '../models/onboarding_info.dart';
import '../views/login_page.dart';

class OnboardingController extends GetxController with BaseController {
  var selectedPageIndex = 0.obs;
  bool get isLastPage => selectedPageIndex.value == onboardingPages.length - 1;
  var pageController = PageController();

  forwardAction() {
    if (isLastPage) {
      checkUserRole();
    } else {
      pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
    }
  }
  void checkUserRole() async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

    if (userId.isNotEmpty) {
      showLoading();
      try {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();
        Map<String, dynamic>? userData = userSnapshot.data() as Map<String, dynamic>?;

        if (userData != null) {
          bool isDriver = userData['isDriver'] ?? false;

          if (isDriver) {
            // Navigate to the driver dashboard
            Get.offNamed(AppRoutes.bottomNavigation);
          } else {
            // Navigate to the client dashboard
            Get.offNamed(AppRoutes.dashboard);
          }
          hideLoading();
        } else {
          // Handle the case when user data is not found
        }
      } catch (error) {
        // Handle the error
      }
    } else {
      Get.offNamed(AppRoutes.login);
    }
  }
  List<OnboardingInfo> onboardingPages = [
    OnboardingInfo('assets/order.jpg', 'Passer votre commande', 'Maintenant, vous pouvez commander à tout moment depuis votre téléphone.'),
    OnboardingInfo('assets/quick delivery.jpg', 'Livraison rapide', 'Les commandes seront livrées immédiatement.'),
    OnboardingInfo('assets/paiement.jpg', 'Paiement', 'Vous pouvez payer avec différentes méthodes.'),
  ];

}