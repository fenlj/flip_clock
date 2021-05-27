import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlipClockNumItem extends StatelessWidget {
  final Color backgroundColor;
  final double textSize;
  final double? borderWidth;
  final Color? borderColor;
  final Color textColor;
  final Size size;
  final int num;
  final FontWeight fontWeight;
  final double? radius;

  const FlipClockNumItem({
    Key? key,
    required this.num,
    this.textSize = 16,
    this.backgroundColor = Colors.black,
    this.textColor = Colors.white,
    this.borderColor,
    this.borderWidth,
    this.size = const Size(48, 48),
    this.fontWeight = FontWeight.bold,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
          color: backgroundColor,
          border: borderColor != null
              ? Border.all(color: borderColor!, width: borderWidth ?? 10)
              : null,
          borderRadius: radius != null
              ? BorderRadius.all(Radius.circular(radius!))
              : null),
      child: Center(
        child: Text(
          "$num",
          style: TextStyle(
            fontSize: textSize,
            color: textColor,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
