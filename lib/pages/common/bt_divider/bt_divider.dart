import 'package:flutter/material.dart';

class BtDivider extends StatelessWidget {
  int shade;
  double thickness;
  double space;

  BtDivider({
    super.key,
    this.shade = 1,
    this.thickness = 1,
    this.space = 0
  });

  Color getLineColor(int shadeValue) {
    switch(shadeValue){
      case 1:
        return Colors.grey.shade300;
      case 2:
        return Colors.grey.shade400;
      case 3:
        return Colors.grey.shade500;
      case 4:
        return Colors.grey.shade600;
      default:
        return Colors.grey.shade200;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: getLineColor(shade), // Color of the line
      thickness: thickness, // Thickness of the line
      indent: space, // Left padding
      endIndent: space, // Right padding
    );
  }
}
