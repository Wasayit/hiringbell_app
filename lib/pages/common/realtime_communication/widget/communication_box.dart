import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/pages/common/realtime_communication/chat_stream_service.dart';
import 'package:hiringbell/pages/comments/model/message_type.dart';
import 'package:hiringbell/pages/comments/model/request_message.dart';
import 'package:hiringbell/pages/common/realtime_communication/chat_bubble/receiver_text_button.dart';
import 'package:hiringbell/pages/common/realtime_communication/chat_bubble/sender_text_bubble.dart';

class CommunicationBox extends GetView<ChatStreamService> {
  const CommunicationBox({super.key});

  Widget getMessageWidget(RequestMessage message) {
    switch (message.type) {
      case MessageType.audio:
        return Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              width: 200,
              margin: const EdgeInsets.only(
                top: 12,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 10,
              ),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade200,
                        border: Border.all(
                          color: Colors.orange, // Border color
                          width: 1.0, // Border width
                        ),
                      ),
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        child: Icon(
                          Icons.perm_identity_rounded,
                        ),
                      ),
                    ),
                    if (controller.isRecordPlaying.value)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            // onPressed: controller.playRecording,
                            icon: const Icon(Icons.pause), onPressed: () {  },
                          ),
                          Image.asset(
                            "assets/audio-file.gif",
                            height: 50,
                          ),
                        ],
                      )
                    else
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: controller.playRecording,
                            icon: const Icon(Icons.play_arrow),
                          ),
                          const Text(
                            "press play button",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      case MessageType.video:
        return const Text("NA");
      default:
        if (message.senderId == controller.user.userId.toString()) {
          return SenderTextBubble(
            message: message.content,
          );
        }
        return ReceiverTextBubble(
          message: message.content,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.only(
          top: 10,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 10,
        ),
        child: controller.chatMessage.value.isEmpty
            ? Container()
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.chatMessage.value.length,
                itemBuilder: (context, index) {
                  return getMessageWidget(controller.chatMessage.value[index]);
                },
              ),
      ),
    );
  }
}
