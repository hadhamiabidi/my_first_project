import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_colors.dart';
import '../controllers/conversations_controller.dart';
import '../widgets/conversation_item.dart';

class ConversationsPage extends StatelessWidget {
  final ConversationsController controller = Get.put(ConversationsController());

  ConversationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        title: Text("Liste de conversation"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: controller.chatsStream(FirebaseAuth.instance.currentUser!.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    final List<DocumentSnapshot<Map<String, dynamic>>> listDocsChats = snapshot.data!.docs;

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: listDocsChats.length,
                      itemBuilder: (context, index) {
                        final String connection = listDocsChats[index]['connection'];

                        return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                          stream: controller.friendStream(connection ?? ''),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.active) {
                              final Map<String, dynamic>? data = snapshot.data?.data();
                              final String fullName = "${data?['firstName']} ${data?['lastName']}";
                              final String initials = _getInitials(fullName);
                              final bool hasUnreadMessages = listDocsChats[index]['total_unread'] != 0;

                              return Material(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: Colors.black, width: 1),
                                ),
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                  onTap: () => controller.goToChatRoom(
                                    listDocsChats[index].id,
                                    FirebaseAuth.instance.currentUser!.uid,
                                    connection,
                                  ),
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.black,
                                    child: Text(
                                      initials.toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    fullName.toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  trailing: hasUnreadMessages
                                      ? Chip(
                                    backgroundColor: Colors.red[900],
                                    label: Text(
                                      "${listDocsChats[index]['total_unread']}",
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  )
                                      : SizedBox(),
                                ),
                              );
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getInitials(String fullName) {
    final List<String> names = fullName.split(" ");
    final StringBuffer initials = StringBuffer();

    for (final name in names) {
      initials.write(name[0]);
    }

    return initials.toString();
  }
}
