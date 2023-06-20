import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxBool isLoading = false.obs;
  RxBool hasError = false.obs;
  RxString errorMessage = ''.obs;
  RxList<Map<String, dynamic>> claims = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    try {
      isLoading.value = true;
      final claimsSnapshot = await _firestore.collection('claims').get();

      // Fetch the users collection
      final usersSnapshot = await _firestore.collection('users').get();
      final usersMap = Map.fromIterable(usersSnapshot.docs, key: (doc) => doc.id, value: (doc) => doc.data());

      claims.value = claimsSnapshot.docs.map((doc) {
        final claimData = doc.data() as Map<String, dynamic>;
        final uid = claimData['uid'];

        // Retrieve the user data using the uid
        final userData = usersMap[uid] as Map<String, dynamic>;

        // Merge the claim data with the user data
        final mergedData = {...claimData, ...userData};

        return mergedData;
      }).toList();

      isLoading.value = false;
    } catch (error) {
      hasError.value = true;
      errorMessage.value = error.toString();
      isLoading.value = false;
    }
  }

  void logout() {
    _auth.signOut();
    //Get.offAll(LoginPage()); // Navigate to the login page
  }
}




