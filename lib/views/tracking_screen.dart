import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../controllers/tracking_controller.dart';

class TrackingScreen extends StatelessWidget {
  final TrackingController controller = Get.put(TrackingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Écran de suivi'),
      ),
      body: Center(
        child: Obx(() => GestureDetector(
          onTap: controller.toggleTracking,
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: controller.isTracking.value ? Colors.green : Colors.red,
            ),
            child: controller.isTracking.value
                ? AnimatedContainer(
              duration: Duration(milliseconds: 300),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                border: Border.all(
                  color: Colors.white.withOpacity(0.4),
                  width: 3.0,
                ),
              ),
              child: Center(
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: Icon(
                    Icons.check,
                    key: ValueKey<bool>(controller.isTracking.value),
                    color: Colors.white,
                    size: 60.0,
                  ),
                ),
              ),
            )
                : Container(),
          ),
        )),
      ),
    );
  }
}
