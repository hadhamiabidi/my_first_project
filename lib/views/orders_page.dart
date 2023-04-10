import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/orders_controller.dart';
import '../widgets/custum_app_bar.dart';
import '../widgets/delivery_item.dart';

class OrdersPage extends StatelessWidget {
  final OrdersController deliveryController = Get.put(OrdersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title:  'Liste de commandes',
        showBackButton: true,
      ),
      body: Obx(
            () => ListView.builder(
          itemCount: deliveryController.deliveryItems.length,
          itemBuilder: (BuildContext context, int index) {
                final item = deliveryController.deliveryItems[index];
                return GestureDetector(
                  onTap: () {
                    // Add your click action here, for example:
                    Get.toNamed('/order-details', arguments: item);
                  },
                  child: OrderItemWidget(item: item),
                );
              },

            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your add button action here
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
