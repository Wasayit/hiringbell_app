import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/pages/common/realtime_communication/chat_stream_service.dart';
import 'package:hiringbell/pages/common/realtime_communication/widget/chat_input_section.dart';
import 'package:hiringbell/pages/common/realtime_communication/widget/communication_box.dart';

class ChatStreamIndex extends GetView<ChatStreamService> {
  final String groupId;
  final String senderId;
  final String recipientId;
  final bool isGroupChat;
  final Widget? chatHeaderWidget;

  const ChatStreamIndex({
    super.key,
    this.chatHeaderWidget,
    required this.senderId,
    required this.recipientId,
    this.isGroupChat = false,
    this.groupId = "",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: ListView(
              shrinkWrap: true,
              controller: controller.scrollController,
              children: [
                chatHeaderWidget == null
                    ? const SizedBox.shrink()
                    : chatHeaderWidget!,
                const CommunicationBox(),
                const SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ChatInputSection(
              senderId: senderId,
              recipientId: recipientId,
              isGroupChat: true,
              groupId: groupId,
            ),
          ),
        ],
      ),
    );
  }
}
