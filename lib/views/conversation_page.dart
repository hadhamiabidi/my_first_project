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
        title: Text("Liste des conversations"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: controller.chatsStream(FirebaseAuth.instance.currentUser!.uid),
                builder: (context, snapshot1) {
                  if (snapshot1.connectionState == ConnectionState.active) {
                    var listDocsChats = snapshot1.data!.docs;
                    if (listDocsChats.isEmpty) {
                      return Text('');
                    }
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: listDocsChats.length,
                      itemBuilder: (context, index) {
                        return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                          stream: controller.friendStream(listDocsChats[index]["connection"]),
                          builder: (context, snapshot2) {
                            if (snapshot2.connectionState == ConnectionState.active) {
                              var data = snapshot2.data!.data();
                              if (data?["status"] == "") {
                                return ListTile(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                  onTap: () => controller.goToChatRoom(
                                    "${listDocsChats[index].id}",
                                    FirebaseAuth.instance.currentUser!.email!,
                                    listDocsChats[index]["connection"],
                                  ),
                                  leading: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.black26,
                                    child: Text(
                                      "${data?["firstName"][0].toUpperCase()}${data?["lastName"][0].toUpperCase()}",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    "${data?["firstName"]} ${data?["lastName"]}",
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  trailing: listDocsChats[index]["total_unread"] == 0
                                      ? SizedBox()
                                      : Chip(
                                    backgroundColor: Colors.red[900],
                                    label: Text(
                                      "${listDocsChats[index]["total_unread"]}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Material(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(color: Colors.red, width: 1),
                                  ),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                    onTap: () => controller.goToChatRoom(
                                      "${listDocsChats[index].id}",
                                      FirebaseAuth.instance.currentUser!.email!,
                                      listDocsChats[index]["connection"],
                                    ),
                                    leading: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.black26,
                                      child: Text(
                                        "${data?["firstName"][0].toUpperCase()}${data?["lastName"][0].toUpperCase()}",
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      "${data?["firstName"]} ${data?["lastName"]}",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    trailing: listDocsChats[index]["total_unread"] == 0
                                        ? SizedBox()
                                        : Chip(
                                      backgroundColor: Colors.red[900],
                                      label: Text(
                                        "${listDocsChats[index]["total_unread"]}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );
                      },
                    );
                  } else if (snapshot1.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Text('');
                  }
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
