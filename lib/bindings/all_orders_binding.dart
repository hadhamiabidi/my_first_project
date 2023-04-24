import 'package:get/get.dart';
import 'package:pfe/controllers/all_orders_controller.dart';



class AllOrders extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AllOrdersController());
  }
}