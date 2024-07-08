import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiringbell/pages/common/realtime_communication/chat_stream_service.dart';

class ChatInputSection extends GetView<ChatStreamService> {
  final String groupId;
  final String senderId;
  final String recipientId;
  final bool isGroupChat;

  const ChatInputSection({
    super.key,
    required this.senderId,
    required this.recipientId,
    this.isGroupChat = false,
    this.groupId = ""
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              margin: const EdgeInsets.only(
                left: 18,
                top: 10,
                bottom: 10,
                right: 0,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.grey[200]!,
                ),
              ),
              child: Obx(
                () => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(
                      width: 10,
                    ),
                    if (controller.isRecording.value)
                      Expanded(
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              "Recording",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Image.asset("assets/loading.gif", width: 40,),
                          ],
                        ),
                      )
                    else
                      Expanded(
                        child: TextField(
                          controller: controller.messageController,
                          // readOnly: true,
                          decoration: const InputDecoration(
                            hintText: 'Type a message (currently disable)',
                            border: InputBorder.none,
                          ),
                          onChanged: (text) { },
                        ),
                      ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        controller.send(groupId, senderId, recipientId, isGroupChat);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 60,
            child: CircleAvatar(
              backgroundColor: Colors.green,
              child: GestureDetector(
                onLongPress: controller.startRecording,
                onLongPressUp: controller.stopRecording,
                child: const Icon(Icons.mic, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
