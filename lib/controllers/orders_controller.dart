import 'package:get/get.dart';
import 'package:pfe/routes/app_routes.dart';

import '../models/order_model.dart';

class OrdersController extends GetxController {

  final deliveryItems = [
    Order(
      title: 'Delivery 1',
      startAddress: '123 Main St',
      destinationAddress: '456 Elm St',
      status: 'Pending',
      price: 123
    ),
    Order(
      title: 'Delivery 2',
      startAddress: '789 Oak St',
      destinationAddress: '101 Pine St',
      status: 'Delivered',
      price: 321
    ),
    // add more delivery items here...
  ].obs;

  void goToAddOrder() {
    Get.toNamed(AppRoutes.addOrder);
  }

}