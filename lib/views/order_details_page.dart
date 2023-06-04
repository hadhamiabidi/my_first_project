import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../config/Utils.dart';
import '../controllers/order_details_controller.dart';
import '../widgets/custum_app_bar.dart';

class OrderDetailsPage extends StatelessWidget {

  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {

    final OrderDetailsController orderDetailsController =
    Get.put(OrderDetailsController());
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
                      Expanded(
                        child: FutureBuilder<String>(
                          future: Utils.getAddressFromLatLng(Utils.parseLatLng(orderDetailsController.getOrder().start_location)),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Lieu de départ",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return const Text('Échec de la récupération de l\'adresse');
                            } else {
                              return const Text('Chargement...');
                            }
                          },
                        ),
                      )
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
                      Expanded(
                        child: FutureBuilder<String>(
                          future: Utils.getAddressFromLatLng(Utils.parseLatLng(orderDetailsController.getOrder().destination_location)),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Lieu de destination",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              );
                            } else if (snapshot.hasError) {
                              return const Text('Échec de la récupération de l\'adresse');
                            } else {
                              return const Text('Chargement...');
                            }
                          },
                        ),
                      )
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
                          'Statut: ${orderDetailsController.getOrder().status == 0 ? "En attendant" : orderDetailsController.getOrder().status == -1 ? "Annulé" : orderDetailsController.getOrder().status == 1 ? "Accepté" : orderDetailsController.getOrder().status == 2 ? "Livré" : "En cours"}',
                          style: TextStyle(
                            color: orderDetailsController.isCancelled()
                                ? Colors.red
                                : Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (orderDetailsController.isDriver==false && orderDetailsController.getOrder().status==0)
                          ElevatedButton(
                            onPressed: orderDetailsController.cancelOrder,
                            child: Text('Annuler la commande'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                            ),
                          ),
                        if(orderDetailsController.isDriver==true && orderDetailsController.getOrder().status==0)
                          ElevatedButton(
                            onPressed: ()=>{
                              orderDetailsController.acceptOrder()
                            },
                            child: Text('Accepter la commande'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                            ),
                          ),
                        if(orderDetailsController.isDriver==true && orderDetailsController.getOrder().status==1)
                          ElevatedButton(
                            onPressed: ()=>{
                              orderDetailsController.setDelivred()
                            },
                            child: Text('Livré'),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                            ),
                          ),

                      ],
                    ),

                  ),
                  if (!orderDetailsController.isDriver && orderDetailsController.getOrder().status != 0)
                    TextButton.icon(
                      onPressed: () {
                        // Add your functionality here
                        orderDetailsController.goToConversation(orderDetailsController.getOrder().driver_id);
                      },
                      icon: Icon(Icons.chat),
                      label: Text('Contacter le livreur'),
                      style: TextButton.styleFrom(
                        primary: Colors.green,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.green),
                        ),
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


