import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pfe/models/user.dart';
import 'package:pfe/routes/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pfe/views/about_us.dart';


class ProfileController extends GetxController {
  Rx<UserModel> currentUser = Rx<UserModel>(UserModel.empty());
  @override
  void onReady() {
    super.onReady();
    getCurrentUserData();
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(AppRoutes.login);
  }

  Future<void> getCurrentUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (snapshot.exists) {
          // User data found in Firestore
          Map<String, dynamic>? userData = snapshot.data() as Map<String, dynamic>?;
          // Set the user data into the currentUser object
          currentUser.value = UserModel.fromJson(userData ?? {}); // Replace UserModel with your User model
        } else {
          // User data not found in Firestore
          // Handle the scenario accordingly
        }
      } else {
        // User is not signed in
        // Handle the scenario accordingly
      }
    } catch (e) {
      // Handle any potential errors
    }
  }

  goToAboutUs() {
    Get.toNamed(AppRoutes.aboutUs);
  }

  goToSettings() {
    Get.toNamed(AppRoutes.settings);

  }

}
