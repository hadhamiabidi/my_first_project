import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pfe/config/base_controller.dart';
import 'package:pfe/routes/app_routes.dart';

import '../models/order_model.dart';

class OrdersController extends GetxController with BaseController{

  final currentUser = FirebaseAuth.instance.currentUser!;
  final deliveryItems = <OrderModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _fetchOrders();
  }



  Future<void> _fetchOrders() async {
    //showLoading();
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where('user_id', isEqualTo: currentUser.uid)
          .get();
      print("Moussa data");
      print(querySnapshot.docs);
      deliveryItems.assignAll(
        querySnapshot.docs.map((doc) => OrderModel.fromMap(doc.data(), doc.id)).toList(),
      );
      hideLoading();
      print(deliveryItems.value[0]);
    } catch (e) {
      hideLoading();
      print("ERROR");
      print(e);
      // handle error
    }
  }

  void goToAddOrder() {
    Get.toNamed(AppRoutes.addOrder);
  }



  void goToOrderDetails(OrderModel item) {
    Get.toNamed(AppRoutes.order, arguments: item);
  }

}
