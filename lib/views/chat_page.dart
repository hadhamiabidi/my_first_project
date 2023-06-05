import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../config/app_colors.dart';
import '../controllers/chat_controller.dart';
import '../widgets/message_item.dart';

class ChatPage extends GetView<ChatController> {
  final String chat_id = (Get.arguments as Map<String, dynamic>)["chat_id"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leadingWidth: 100,
        leading: InkWell(
          onTap: () => Get.back(),
          borderRadius: BorderRadius.circular(100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 5),
              const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              const SizedBox(width: 5),
            ],
          ),
        ),
        title: StreamBuilder<DocumentSnapshot<Object?>>(
          stream: controller.streamFriendData(
              (Get.arguments as Map<String, dynamic>)["chat_id"]),
          builder: (context, snapFriendUser) {
            if (snapFriendUser.connectionState == ConnectionState.active) {
              var dataFriend =
              snapFriendUser.data!.data() as Map<String, dynamic>;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dataFriend["firstName"],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'جار التحميل...',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'جار التحميل...',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            );
          },
        ),
        centerTitle: false,
      ),
      body: WillPopScope(
        onWillPop: () {
          if (controller.isShowEmoji.isTrue) {
            controller.isShowEmoji.value = false;
          } else {
            Navigator.pop(context);
          }
          return Future.value(false);
        },
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: controller.streamChats(chat_id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      var alldata = snapshot.data!.docs;
                      Timer(
                        Duration.zero,
                            () => controller.scrollC.jumpTo(
                            controller.scrollC.position.maxScrollExtent),
                      );
                      return ListView.builder(
                        controller: controller.scrollC,
                        itemCount: alldata.length,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Column(
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  "${alldata[index]["groupTime"]}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ItemChat(
                                  msg: "${alldata[index]["msg"]}",
                                  isSender: alldata[index]["pengirim"] ==
                                      FirebaseAuth.instance.currentUser?.uid
                                      ? true
                                      : false,
                                  time: "${alldata[index]["time"]}",
                                ),
                              ],
                            );
                          } else {
                            if (alldata[index]["groupTime"] ==
                                alldata[index - 1]["groupTime"]) {
                              return ItemChat(
                                msg: "${alldata[index]["msg"]}",
                                isSender: alldata[index]["pengirim"] ==
                                    FirebaseAuth.instance.currentUser?.uid
                                    ? true
                                    : false,
                                time: "${alldata[index]["time"]}",
                              );
                            } else {
                              return Column(
                                children: [
                                  Text(
                                    "${alldata[index]["groupTime"]}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  ItemChat(
                                    msg: "${alldata[index]["msg"]}",
                                    isSender: alldata[index]["pengirim"] ==
                                        FirebaseAuth.instance.currentUser?.uid
                                        ? true
                                        : false,
                                    time: "${alldata[index]["time"]}",
                                  ),
                                ],
                              );
                            }
                          }
                        },
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                bottom: controller.isShowEmoji.isTrue
                    ? 5
                    : context.mediaQueryPadding.bottom,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: Get.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      autocorrect: false,
                      controller: controller.chatC,
                      focusNode: controller.focusNode,
                      onEditingComplete: () => controller.newChat(
                        FirebaseAuth.instance.currentUser!.uid,
                        Get.arguments as Map<String, dynamic>,
                        controller.chatC.text,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: IconButton(
                          onPressed: () {
                            controller.focusNode.unfocus();
                            controller.isShowEmoji.toggle();
                          },
                          icon: const Icon(Icons.emoji_emotions_outlined),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Material(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.red[900],
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () => controller.newChat(
                        'admin@admin.com',
                        Get.arguments as Map<String, dynamic>,
                        controller.chatC.text,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(
                  () => (controller.isShowEmoji.isTrue)
                  ? SizedBox(
                height: 325,
                child: EmojiPicker(
                  onEmojiSelected: (category, emoji) {
                    controller.addEmojiToChat(emoji);
                  },
                  onBackspacePressed: () {
                    controller.deleteEmoji();
                  },
                  config: const Config(
                    backspaceColor: Color(0xFFB71C1C),
                    columns: 7,
                    emojiSizeMax: 32.0,
                    verticalSpacing: 0,
                    horizontalSpacing: 0,
                    initCategory: Category.RECENT,
                    bgColor: Color(0xFFF2F2F2),
                    indicatorColor: Color(0xFFB71C1C),
                    iconColor: Colors.grey,
                    iconColorSelected: Color(0xFFB71C1C),
                    recentsLimit: 28,
                    categoryIcons: CategoryIcons(),
                    buttonMode: ButtonMode.MATERIAL,
                  ),
                ),
              )
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}

class ItemChat extends StatelessWidget {
  const ItemChat({
    Key? key,
    required this.isSender,
    required this.msg,
    required this.time,
  }) : super(key: key);

  final bool isSender;
  final String msg;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
      ),
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
        isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.red[900],
              borderRadius: isSender
                  ? const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              )
                  : const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            padding: EdgeInsets.all(15),
            child: Text(
              "$msg",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(DateFormat.jm().format(DateTime.parse(time))),
        ],
      ),
    );
  }
}