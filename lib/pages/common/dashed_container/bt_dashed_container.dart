import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../models/constants.dart';

class BtDashedContainer extends StatelessWidget {
  final Widget child;
  final String content;
  final bool isUserWidget;

  const BtDashedContainer({
    super.key,
    required this.child,
    required this.content,
  })  : assert(true),
        isUserWidget = false;

  const BtDashedContainer.styled({
    super.key,
    required this.child,
    this.content = Constants.empty,
  })  : assert(true),
        isUserWidget = true;

  Widget bindWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        child,
        const SizedBox(
          height: 10,
        ),
        Text(
          content,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: Constants.fontSize * .9,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget getWidget() {
    if (isUserWidget) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          child,
          const SizedBox(
            height: 10,
          ),
          if (content.isNotEmpty)
            Text(
              content,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: Constants.fontSize * .9,
              ),
              textAlign: TextAlign.center,
            )
          else
            const SizedBox.shrink(),
        ],
      );
    } else {
      return bindWidget();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      color: Colors.grey,
      radius: const Radius.circular(12),
      padding: const EdgeInsets.all(6),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
        child: Container(
          height: 120,
          width: double.infinity,
          color: Colors.grey.shade100,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Center(
            child: getWidget(),
          ),
        ),
      ),
    );
  }
}
