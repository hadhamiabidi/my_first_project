import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/admin_controller.dart';

class AdminPage extends StatelessWidget {
  final AdminController controller = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste de réclamation'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.logout,
        child: Icon(Icons.logout),
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else if (controller.hasError.value) {
            return Center(child: Text('Error: ${controller.errorMessage.value}'));
          } else {
            final claims = controller.claims.value;

            return ListView.builder(
              itemCount: claims.length,
              itemBuilder: (BuildContext context, int index) {
                final claim = claims[index];
                final bool isTreated = claim['isTreated'] ?? false;

                return GestureDetector(
                  onTap: () {
                    controller.showResponseBottomSheet(context, claim);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          child: CircleAvatar(
                            child: Text(
                              '${claim['firstName'][0]}${claim['lastName'][0]}',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.black, // Changed background color to black
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${claim['firstName']} ${claim['lastName']}',
                                style: TextStyle(fontWeight: FontWeight.bold), // Added bold style
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Problème: ${claim['title']}',
                                style: TextStyle(
                                  color: isTreated ? Colors.green : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ), // Modified label to "Problème"
                              if (claim['description'] != null)
                                Text(
                                  'Réponse: ${claim['description']}',
                                  style: TextStyle(
                                    color: claim['description'].isNotEmpty ? Colors.green : Colors.red,
                                  ),
                                ), // Modified label to "Réponse"
                            ],
                          ),
                        ),
                        if (claim['profilePictureUrl'] != null && claim['profilePictureUrl'] != '')
                          Container(
                            margin: EdgeInsets.all(10),
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(claim['profilePictureUrl']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}
