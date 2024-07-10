import 'package:flutter/material.dart';
import 'dart:ui' as ui;


class BtListTile extends StatelessWidget {
  Widget left;
  Widget right;

  BtListTile({
    super.key,
    required this.left,
    required this.right,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * .2,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              left,
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * .69,
          child: right,
        ),
      ],
    );
  }
}
