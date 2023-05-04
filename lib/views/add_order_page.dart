import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe/widgets/submit_button.dart';
import '../controllers/add_order_controller.dart';
import '../widgets/custum_app_bar.dart';
import '../widgets/custum_text_field.dart';

class AddOrderScreen extends StatelessWidget {

  const AddOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AddOrderController controller = Get.put(AddOrderController());

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
                controller: controller.titleController,
              ),
              CustomTextField(
                label: 'Description',
                hint: 'Entrez la description',
                controller: controller.descriptionController,
                maxLines: 5,
              ),
              CustomTextField(
                label: 'Prix',
                hint: 'Entrez le prix',
                controller: controller.priceController,
              ),
              CustomTextField(
                label: 'La date de livraison',
                hint: 'Entrez la date de livraison',
                controller: controller.deliveryDateController,
                readOnly: true,
                onTap:()=>{
                  controller.selectDeliveryDate()
                },
              ),
              CustomTextField(
                label: 'Adresse de ramassage',
                hint: "Entrez l'adresse de ramassage",
                controller: controller.startLocationController,
                readOnly: true,
                onTap:()=>{
                  controller.selectLocationAddress(controller.startLocationController)
                },
              ),
              CustomTextField(
                label: 'Adresse de destination',
                hint: "Entrez l'adresse de destination",
                controller: controller.destinationLocationController,
                readOnly: true,
                onTap:()=>{
                  controller.selectLocationAddress(controller.destinationLocationController)
                },
              ),
              SubmitButton(
                label: 'Ajouter une commande',
                onPressed: () => controller.addOrder(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
