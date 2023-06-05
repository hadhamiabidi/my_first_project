import 'package:get/get.dart';
import 'package:pfe/controllers/add_order_controller.dart';
import 'package:pfe/controllers/setting_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsController());
  }
}