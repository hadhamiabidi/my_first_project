import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/admin_controller.dart';

class AdminPage extends StatelessWidget {
  final AdminController _adminController = Get.put(AdminController());

   AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _adminController.logout,
        child: Icon(Icons.logout),
      ),
      body: SafeArea(
        child: GetBuilder<AdminController>(
          builder: (_) {
            if (_.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else if (_.hasError.value) {
              return Center(child: Text('Error: ${_.errorMessage.value}'));
            } else {
              final claims = _.claims.value;

              return ListView.builder(
                itemCount: claims.length,
                itemBuilder: (BuildContext context, int index) {
                  final claim = claims[index];

                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          '${claim['firstName'][0]}${claim['lastName'][0]}',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.blue,
                      ),
                      title: Text('${claim['firstName']} ${claim['lastName']}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(claim['title']),
                          Text(claim['body']),
                          if (claim['description'] != null) Text(claim['description']),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
