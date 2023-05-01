import 'package:get/get.dart';
import 'package:pfe/controllers/add_order_controller.dart';

class AddOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddOrderController());
  }
}