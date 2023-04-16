import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe/widgets/submit_button.dart';
import '../controllers/add_order_controller.dart';
import '../widgets/custum_app_bar.dart';
import '../widgets/custum_text_field.dart';

class AddOrderScreen extends StatelessWidget {
  final AddOrderController _controller = Get.put(AddOrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Add Order', showBackButton: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextField(
                label: 'Titre',
                hint: 'Entrez le titre',
                controller: _controller.titleController,
              ),
              CustomTextField(
                label: 'Description',
                hint: 'Entrez la description',
                controller: _controller.descriptionController,
                maxLines: 5,
              ),
              CustomTextField(
                label: 'Prix',
                hint: 'Entrez le prix',
                controller: _controller.descriptionController,
              ),
              CustomTextField(
                label: 'La date de livraison',
                hint: 'Entrez la date de livraison',
                controller: _controller.deliveryDateController,
                readOnly: true,
                onTap:()=>{
                  _controller.selectDeliveryDate()
                },
              ),
              CustomTextField(
                label: 'Adresse de ramassage',
                hint: "Entrez l'adresse de ramassage",
                controller: _controller.startLocationController,
                readOnly: true,
                onTap:()=>{
                  _controller.selectLocationAddress(_controller.startLocationController)
                },
              ),
              CustomTextField(
                label: 'Adresse de destination',
                hint: "Entrez l'adresse de destination",
                controller: _controller.destinationLocationController,
                readOnly: true,
                onTap:()=>{
                  _controller.selectLocationAddress(_controller.destinationLocationController)
                },
              ),
              SubmitButton(
                label: 'Ajouter une commande',
                onPressed: () => _controller.addOrder(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
