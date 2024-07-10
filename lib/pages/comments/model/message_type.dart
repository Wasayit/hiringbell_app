enum MessageType { audio, video, text }

extension TypeExtension on MessageType {
  int get value {
    switch(this) {
      case MessageType.audio:
        return 0;
      case MessageType.video:
        return 1;
      default:
        return 2;
    }
  }
}