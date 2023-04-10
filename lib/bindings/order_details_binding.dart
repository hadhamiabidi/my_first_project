import 'package:get/get.dart';
import 'package:pfe/controllers/order_details_controller.dart';


class OrderDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderDetailsController());
  }
}