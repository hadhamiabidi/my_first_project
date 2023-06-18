import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/claims_controller.dart';
import '../widgets/custum_app_bar.dart';

class ClaimsPage extends StatelessWidget {
  const ClaimsPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final ClaimsController controller = Get.put(ClaimsController());

    return Scaffold(
      appBar: const MyAppBar(
        title: 'Liste de réclamations',
        showBackButton: true,
      ),
      body: Obx(
            () => ListView.builder(
          itemCount: controller.claims.length,
          itemBuilder: (BuildContext context, int index) {
            final claim = controller.claims[index];
            final bool isDescriptionEmpty = claim.description.isEmpty;
            final Color backgroundColor = isDescriptionEmpty ? Colors.yellowAccent : Colors.greenAccent;

            return Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow:  [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        claim.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        claim.date.substring(0, 19),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    claim.description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.addNewClaim();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
