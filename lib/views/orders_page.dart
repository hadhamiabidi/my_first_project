import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/orders_controller.dart';
import '../widgets/custum_app_bar.dart';
import '../widgets/delivery_item.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OrdersController controller = Get.put(OrdersController());

    return Scaffold(
      appBar: const MyAppBar(
        title: 'Liste de commandes',
        showBackButton: true,
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.deliveryItems.length,
          itemBuilder: (BuildContext context, int index) {
            final item = controller.deliveryItems[index];
            return GestureDetector(
              onTap: () {
                controller.goToOrderDetails(item);
              },
              child: OrderItemWidget(item: item),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.goToAddOrder();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
