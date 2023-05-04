import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pfe/config/base_controller.dart';

import '../models/claim_model.dart';

class ClaimsController extends GetxController with BaseController {
  final RxList<Claim> claims = <Claim>[].obs;

  @override
  void onReady() {
    super.onReady();
    fetchClaims();
  }

  Future<void> fetchClaims() async {
    showLoading();
    final claimsCollection = FirebaseFirestore.instance.collection('claims');
    final querySnapshot = await claimsCollection.get();

    final newClaims = <Claim>[];
    for (final doc in querySnapshot.docs) {
      final data = doc.data();
      final claim = Claim.fromJson({
        'uid': doc.id,
        ...data,
      });
      newClaims.add(claim);
    }

    claims.addAll(newClaims);
    hideLoading();
  }
}
