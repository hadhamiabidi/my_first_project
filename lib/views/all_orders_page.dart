import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/all_orders_controller.dart';
import '../widgets/custum_app_bar.dart';
import '../widgets/delivery_item.dart';

class AllOrdersPage extends StatelessWidget {
  const AllOrdersPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final AllOrdersController controller = Get.put(AllOrdersController());

    return Scaffold(
      appBar: const MyAppBar(
        title: 'Liste de commandes',
      ),
      body: Obx(
            () => ListView.builder(
          itemCount: controller.deliveryItems.isEmpty ? 1 : controller.deliveryItems.length,
          itemBuilder: (BuildContext context, int index) {
            if (controller.deliveryItems.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.local_shipping,
                      size: 64,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Aucune commande',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              final item = controller.deliveryItems[index];
              return GestureDetector(
                onTap: () {
                  Get.toNamed('/order-details', arguments: {'item': item, 'isDriver': true});
                },
                child: OrderItemWidget(item: item),
              );
            }
          },
        ),
      ),
    );
  }
}
