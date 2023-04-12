import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../controllers/order_details_controller.dart';
import '../widgets/custum_app_bar.dart';

class OrderDetailsPage extends StatelessWidget {
  final OrderDetailsController orderDetailsController =
  Get.put(OrderDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Détails de la commande', showBackButton: true),
      body: Column(
        children: [
          Container(
            height: 250,
            child: GoogleMap(
              initialCameraPosition:
              orderDetailsController.getInitialCameraPosition(),
              onMapCreated: (controller) =>
              orderDetailsController.mapController = controller,
              markers: orderDetailsController.getMarkers(),
              polylines: orderDetailsController.getPolylines(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 10,
                      ),
                      const SizedBox(width: 8),
                      Text(orderDetailsController.getStartAddress()),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 10,
                      ),
                      const SizedBox(width: 8),
                      Text(orderDetailsController.getDestinationAddress()),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Prix ​​total: \$${orderDetailsController.getOrder().price}',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Statut: ${orderDetailsController.isCancelled() ? "Annulé" : "En cours"}',
                          style: TextStyle(
                            color: orderDetailsController.isCancelled()
                                ? Colors.red
                                : Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (!orderDetailsController.isCancelled())
                          ElevatedButton(
                            onPressed: orderDetailsController.cancelOrder,
                            child: Text('Annuler la commande'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
