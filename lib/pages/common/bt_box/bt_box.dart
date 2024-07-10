import 'package:flutter/material.dart';

class BtBox extends StatelessWidget {
  Widget child;
  double hSpace;
  BtBox({super.key, required this.child, this.hSpace = 10.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: hSpace,
      ),
      child: child,
    );
  }
}
