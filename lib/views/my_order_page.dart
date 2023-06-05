import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/my_order_controller.dart';
import '../widgets/custum_app_bar.dart';
import '../widgets/delivery_item.dart';

class MyOrderPage extends StatelessWidget {
  final MyOrderController controller = Get.put(MyOrderController());

   MyOrderPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const MyAppBar(
        title: 'Mes commandes',
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.orders.length,
          itemBuilder: (BuildContext context, int index) {
            final item = controller.orders[index];
            return GestureDetector(
              onTap: () {
              controller.goToOrderDetails(item);
              },
              child: OrderItemWidget(item: item),
            );
          },
        ),
      ),
    );
  }
}
