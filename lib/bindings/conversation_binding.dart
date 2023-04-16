import 'package:get/get.dart';
import 'package:pfe/controllers/conversations_controller.dart';

class ConversationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ConversationsController());
  }
}