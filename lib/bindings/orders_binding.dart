import 'package:get/get.dart';
import 'package:pfe/controllers/orders_controller.dart';


class OrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrdersController());
  }
}