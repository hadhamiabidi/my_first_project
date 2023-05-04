import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pfe/config/base_controller.dart';

import '../models/order_model.dart';
import '../routes/app_routes.dart';

class MyOrderController extends GetxController with BaseController {
  final orders = <OrderModel>[].obs;

  @override
  void onReady() {
    super.onReady();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    showLoading();

    final querySnapshot = await FirebaseFirestore.instance
        .collection('orders')
        .where('status', isEqualTo: 1)
        .where('driver_uid', isEqualTo: user.uid)
        .get();

    orders.assignAll(
      querySnapshot.docs.map(
            (doc) => OrderModel.fromMap(doc.data(), doc.id),
      ),
    );
    hideLoading();
  }

  void goToOrderDetails(OrderModel item) {
    Get.toNamed(AppRoutes.order, arguments: item);
  }
}
