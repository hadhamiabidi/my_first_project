import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class BottomNavigationController extends GetxController {
  var selectedIndex = 0.obs;
  var textValue = 0.obs;
  void changedIndex( int index) {
    selectedIndex.value = index;
  }


}