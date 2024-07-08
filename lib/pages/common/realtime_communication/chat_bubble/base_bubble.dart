import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:hiringbell/pages/common/realtime_communication/chat_bubble/triangle_paint.dart';

class BaseBubble extends StatelessWidget {
  final String message;
  final Color color;
  final Color textColor;
  final bool isSender;

  const BaseBubble({
    super.key,
    required this.message,
    required this.color,
    required this.textColor,
    this.isSender = true,
  });

  EdgeInsets getEdge() {
    if (isSender) {
      return const EdgeInsets.only(
        right: 18.0,
        left: 50,
        top: 5,
        bottom: 5,
      );
    } else {
      return const EdgeInsets.only(
        right: 50.0,
        left: 18,
        top: 5,
        bottom: 5,
      );
    }
  }

  BorderRadius getBorderRadius() {
    if (isSender) {
      return const BorderRadius.only(
        topLeft: Radius.circular(18),
        bottomLeft: Radius.circular(18),
        bottomRight: Radius.circular(18),
      );
    } else {
      return const BorderRadius.only(
        topRight: Radius.circular(18),
        bottomLeft: Radius.circular(18),
        bottomRight: Radius.circular(18),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final messageTextGroup = Flexible(
      child: Row(
        mainAxisAlignment:
            isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.start : CrossAxisAlignment.start,
        children: [
          !isSender
              ? Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(math.pi),
                  child: CustomPaint(
                    painter: TrianglePaint(color),
                  ),
                )
              : const SizedBox.shrink(),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 14,
              ),
              decoration: BoxDecoration(
                color: color,
                borderRadius: getBorderRadius(),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    message,
                    style: TextStyle(
                      color: textColor,
                      fontFamily: 'Monstserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text("7:20 pm"),
                ],
              ),
            ),
          ),
          isSender
              ? CustomPaint(
                  painter: TrianglePaint(
                    Colors.amber.shade100,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );

    return Padding(
      padding: getEdge(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          messageTextGroup,
        ],
      ),
    );
  }
}
