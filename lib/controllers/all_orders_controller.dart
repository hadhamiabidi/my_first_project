import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pfe/config/base_controller.dart';

import '../models/order_model.dart';

class AllOrdersController extends GetxController with BaseController {
  final deliveryItems = <OrderModel>[].obs;

  @override
  void onReady() {
    super.onReady();
    _fetchAllOrders();
  }

  Future<void> _fetchAllOrders() async {
    showLoading();
    try {
      final ordersCollection =
      FirebaseFirestore.instance.collection('orders');
      final querySnapshot =
      await ordersCollection.where('status', isEqualTo: 0).get();
      final orders =
      querySnapshot.docs.map((doc) => OrderModel.fromMap(doc.data(),doc.id));
      deliveryItems.assignAll(orders);
      hideLoading();
    } catch (e) {
      // Handle error
      hideLoading();
      print('Error fetching orders: $e');
    }
  }
}
