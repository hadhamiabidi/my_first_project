import 'package:get/get.dart';
import 'package:pfe/controllers/signup_controller.dart';
import '../controllers/login_controller.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignupController());
  }
}