import 'package:get/get.dart';
import 'package:pfe/controllers/claims_controller.dart';

class ClaimsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ClaimsController());
  }
}