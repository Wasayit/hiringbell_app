import 'package:flutter/material.dart';
import 'package:hiringbell/pages/common/realtime_communication/chat_bubble/base_bubble.dart';

class SenderTextBubble extends StatelessWidget {
  final String message;

  const SenderTextBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return BaseBubble(
      message: message,
      color: Colors.amber.shade100,
      textColor: Colors.black87,
      isSender: true,
    );
  }
}
