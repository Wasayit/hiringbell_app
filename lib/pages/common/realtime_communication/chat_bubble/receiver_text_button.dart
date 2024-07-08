import 'package:flutter/material.dart';
import 'package:hiringbell/pages/common/realtime_communication/chat_bubble/base_bubble.dart';

class ReceiverTextBubble extends StatelessWidget {
  final String message;

  const ReceiverTextBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return BaseBubble(
      message: message,
      color: Colors.white,
      textColor: Colors.black87,
      isSender: false,
    );
  }
}
