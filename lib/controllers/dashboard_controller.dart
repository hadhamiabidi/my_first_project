import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pfe/routes/app_routes.dart';

class DashboardController extends GetxController {
  var displayName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();

  }

  void fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (userDoc.exists) {
        displayName.value = userDoc['firstName'] + "" + userDoc['lastName']?? '';
      }
    }
  }

  void goToPage(int index) {
    switch (index) {
      case 1:
        Get.toNamed(AppRoutes.orders);
        break;
      case 4:
        Get.toNamed(AppRoutes.claims);
        break;
      case 5:
        Get.toNamed(AppRoutes.conversations);
        break;
      case 3:
        Get.toNamed(AppRoutes.settings);
        break;
      default:
      // Do nothing
        break;
    }
  }

  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAndToNamed(AppRoutes.login);
    } catch (e) {
      // Handle logout error
      print("Logout error: $e");
    }
  }
}