import 'package:get/get.dart';
import 'package:pfe/controllers/about_us_controller.dart';
import 'package:pfe/controllers/add_order_controller.dart';

class AboutUsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AboutUsController());
  }
}