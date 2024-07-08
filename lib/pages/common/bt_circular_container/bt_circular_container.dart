import 'package:flutter/material.dart';

class BtCircularContainer extends StatelessWidget {
  double radius;
  Widget child;

  BtCircularContainer({super.key, required this.child, required this.radius});

  BoxDecoration getDecorationStyle() {
    return const BoxDecoration(
      shape: BoxShape.circle, // Circular shape
      boxShadow: [
        BoxShadow(
          color: Colors.black26, // Shadow color
          blurRadius: 10.0, // Shadow blur radius
          spreadRadius: 2.0, // Shadow spread radius
          offset: Offset(0, 4), // Shadow offset
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius, // Specify the width of the circle
      height: radius, // Specify the height of the circle
      decoration: getDecorationStyle(),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        child: CircleAvatar(
          radius: radius * .47,
          backgroundColor: Colors.grey.shade300,
          child: const Text("IMG"),
        ),
      ),
    );
  }
}
