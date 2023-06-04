import 'dart:math';

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
    print("fetchOrders");
    print(user!.uid);

    if (user == null) {
      return;
    }
    showLoading();

    final querySnapshot = await FirebaseFirestore.instance
        .collection('orders')
        .where('driver_uid', isEqualTo: user.uid)
        .get();
    print("orders driver");
    print(querySnapshot);
    orders.assignAll(
      querySnapshot.docs.map(
            (doc) => OrderModel.fromMap(doc.data(), doc.id),
      ),
    );
    print(orders.length);
    hideLoading();
  }

  void goToOrderDetails(OrderModel item) {
    Get.toNamed(AppRoutes.order, arguments: {'item': item, 'isDriver': true});
  }
}
