import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pfe/models/order_model.dart';


import '../config/Utils.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderModel item;

  const OrderItemWidget({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final startLocation = Utils.parseLatLng(item.start_location);
    final destinationLocation = Utils.parseLatLng(item.destination_location);

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildLocationRow(
            startLocation,
            'Lieu de départ',
            Icons.location_on_outlined,
          ),
          const SizedBox(height: 8),
          _buildLocationRow(
            destinationLocation,
            'Lieu de destination',
            Icons.location_on,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: item.status == 1
                  ? Colors.green.withOpacity(0.2)
                  : Colors.orange.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              item.status == 0 ? 'En attendant' : item.status == -1 ? "Annulé" : item.status == 1 ? 'Accepté' : 'Delivré',
              style: TextStyle(
                color: item.status == 1 ? Colors.green : item.status == -1? Colors.red : Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationRow(
      LatLng location,
      String title,
      IconData icon,
      ) {
    return Row(
      children: [
        const CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 8,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: FutureBuilder<String>(
            future: Utils.getAddressFromLatLng(location),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
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
        ),
      ],
    );
  }
}
