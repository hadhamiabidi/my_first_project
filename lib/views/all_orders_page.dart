import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/all_orders_controller.dart';
import '../widgets/custum_app_bar.dart';
import '../widgets/delivery_item.dart';

class AllOrdersPage extends StatelessWidget {
  const AllOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AllOrdersController controller = Get.put(AllOrdersController());

    return Scaffold(
      appBar: const MyAppBar(
        title: 'Liste de commandes',
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.deliveryItems.length,
          itemBuilder: (BuildContext context, int index) {
            final item = controller.deliveryItems[index];
            return GestureDetector(
              onTap: () {
                Get.toNamed('/order-details', arguments: {'item': item, 'isDriver': true});
              },

              child: OrderItemWidget(item: item),
            );
          },
        ),
      ),
    );
  }
}
