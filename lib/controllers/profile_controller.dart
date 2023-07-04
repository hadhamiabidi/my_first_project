import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pfe/config/base_controller.dart';
import 'package:pfe/models/user.dart';
import 'package:pfe/routes/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

class ProfileController extends GetxController with BaseController {
  Rx<UserModel> currentUser = Rx<UserModel>(UserModel.empty());
  RxBool isLocationTrackingEnabled = false.obs;

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
          Map<String, dynamic>? userData =
          snapshot.data() as Map<String, dynamic>?;
          // Set the user data into the currentUser object
          currentUser.value = UserModel.fromJson(userData ?? {});
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

  void goToAboutUs() {
    Get.toNamed(AppRoutes.aboutUs);
  }

  void goToSettings() {
    Get.toNamed(AppRoutes.settings);
  }

  Future<void> addPicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      showLoading();
      final imageFile = File(pickedFile.path);

      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final timestamp = DateTime.now().microsecondsSinceEpoch;
        final imageName = '${currentUser.uid}_$timestamp.jpg';

        final storageReference =
        firebase_storage.FirebaseStorage.instance.ref().child('profile_images/$imageName');
        final uploadTask = storageReference.putFile(imageFile);
        await uploadTask.whenComplete(() {});

        final imageUrl = await storageReference.getDownloadURL();

        final userCollection = FirebaseFirestore.instance.collection('users');
        final userDoc = userCollection.doc(currentUser.uid);
        await userDoc.update({'profilePictureUrl': imageUrl});
        getCurrentUserData();
        hideLoading();
      }
    }
  }

  goToTrackingScreen() {
    Get.toNamed(AppRoutes.tracking);
  }
}
