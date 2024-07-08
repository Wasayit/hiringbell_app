import 'message_type.dart';

class RequestMessage {
  String chatId;
  String content;
  String senderId;
  String recipientId;
  DateTime timestamp;
  late MessageType type;

  RequestMessage({
    required this.chatId,
    required this.content,
    required this.senderId,
    required this.recipientId,
    required this.timestamp,
    this.type = MessageType.text,
  });

  static MessageType getMessageType(String type) {
      switch(type) {
        case "video":
          return MessageType.video;
        case "audio":
          return MessageType.audio;
        default:
          return MessageType.text;
      }
  }
}