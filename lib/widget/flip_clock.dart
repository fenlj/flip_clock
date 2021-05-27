import 'package:flip_clock/widget/flip_board.dart';
import 'package:flip_clock/widget/flip_clock_num_item.dart';
import 'package:flutter/material.dart';

class FlipClock extends StatelessWidget {
  final DateTime startTime;
  final EdgeInsets spacing;
  final EdgeInsets spacingForNumText;
  final FlipDirection flipDirection;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final double? borderWidth;
  final FontWeight fontWeight;
  final double? radius;
  final double textSize;
  final Cubic cubic;
  final Duration duration;
  final Size size;
  final bool showSeconds;

  const FlipClock({
    Key? key,
    required this.startTime,
    this.spacing = const EdgeInsets.all(4),
    this.spacingForNumText = const EdgeInsets.all(.25),
    this.flipDirection = FlipDirection.down,
    this.textSize = 16,
    this.backgroundColor = Colors.black,
    this.textColor = Colors.white,
    this.borderColor,
    this.borderWidth,
    this.fontWeight = FontWeight.bold,
    this.radius,
    this.cubic = Curves.easeInOut,
    this.duration = const Duration(milliseconds: 450),
    this.size = const Size(48, 48),
    this.showSeconds = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timeStream =
        Stream<DateTime>.periodic(Duration(milliseconds: 1000), (_) {
      return DateTime.now();
    }).asBroadcastStream();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildPart(
          timeStream.map((DateTime time) => time.hour),
          startTime.hour,
        ),
        Padding(padding: spacing),
        _buildPart(
          timeStream.map((DateTime time) => time.minute),
          startTime.minute,
        ),
        showSeconds ? Padding(padding: spacing) : SizedBox(width: 0),
        showSeconds
            ? _buildPart(
                timeStream.map((DateTime time) => time.second),
                startTime.second,
              )
            : SizedBox(width: 0),
      ],
    );
  }

  Widget _buildPart(Stream<int> timeStream, int initValue) {
    return FlipBoard<int>(
      itemBuilder: (_, value) {
        return _buildText(value);
      },
      stream: timeStream,
      initValue: initValue,
      direction: flipDirection,
      curves: cubic,
      spacing: spacingForNumText,
      duration: duration,
    );
  }

  Widget _buildText(int num) {
    return FlipClockNumItem(
      num: num,
      radius: radius,
      textSize: textSize,
      backgroundColor: backgroundColor,
      textColor: textColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      size: size,
      fontWeight: fontWeight,
    );
  }
}
