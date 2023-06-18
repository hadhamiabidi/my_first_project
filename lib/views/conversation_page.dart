import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_colors.dart';
import '../controllers/conversations_controller.dart';
import '../widgets/conversation_item.dart';

class ConversationsPage extends StatelessWidget {
  const ConversationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ConversationsController controller = Get.put(ConversationsController());

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        title: const Text("Liste des conversations"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: controller.chatsStream(FirebaseAuth.instance.currentUser!.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const SizedBox();
                  }
                  final listDocsChats = snapshot.data!.docs;
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: listDocsChats.length,
                    itemBuilder: (context, index) {
                      final chatDoc = listDocsChats[index];
                      return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        stream: controller.friendStream(chatDoc["connection"]),
                        builder: (context, friendSnapshot) {
                          if (friendSnapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (!friendSnapshot.hasData) {
                            return const SizedBox();
                          }
                          final friendData = friendSnapshot.data!.data();
                          final firstName = friendData?["firstName"];
                          final lastName = friendData?["lastName"];
                          final profilePictureUrl = friendData?["profilePictureUrl"];

                          return ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            onTap: () => controller.goToChatRoom(
                              chatDoc.id,
                              FirebaseAuth.instance.currentUser!.email!,
                              chatDoc["connection"],
                            ),
                            leading: _buildLeadingWidget(firstName, lastName, profilePictureUrl),
                            title: Text(
                              "$firstName $lastName",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            trailing: chatDoc["total_unread"] == 0
                                ? SizedBox()
                                : Chip(
                              backgroundColor: Colors.red[900],
                              label: Text(
                                "${chatDoc["total_unread"]}",
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeadingWidget(String? firstName, String? lastName, String? profilePictureUrl) {
    final initials = (firstName?.isNotEmpty == true ? firstName![0] : '') +
        (lastName?.isNotEmpty == true ? lastName![0] : '');

    if (profilePictureUrl?.isNotEmpty == true) {
      return CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(profilePictureUrl!),
      );
    } else {
      return CircleAvatar(
        radius: 30,
        backgroundColor: Colors.black26,
        child: Text(
          initials.toUpperCase(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
    }
  }
}
