import 'package:get/get.dart';
import '../controllers/profile_controller.dart';



class Profile extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}