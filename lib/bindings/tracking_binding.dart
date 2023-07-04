import 'package:get/get.dart';
import 'package:pfe/controllers/tracking_controller.dart';

class TrackingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TrackingController());
  }
}