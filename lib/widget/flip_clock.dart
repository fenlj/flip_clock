import 'package:flip_clock/widget/flip_board.dart';
import 'package:flip_clock/widget/flip_clock_num_item.dart';
import 'package:flutter/material.dart';

class FlipClock extends StatelessWidget {
  final DateTime startTime;
  final EdgeInsets spacing;
  final FlipDirection flipDirection;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final double? borderWidth;
  final double horizontalSpacing;
  final double verticalSpacing;
  final FontWeight fontWeight;
  final double? radius;
  final double textSize;

  const FlipClock({
    Key? key,
    required this.startTime,
    this.spacing = const EdgeInsets.all(8),
    this.flipDirection = FlipDirection.down,
    this.textSize = 16,
    this.backgroundColor = Colors.black,
    this.textColor = Colors.white,
    this.borderColor,
    this.borderWidth,
    this.horizontalSpacing = 8,
    this.verticalSpacing = 12,
    this.fontWeight = FontWeight.bold,
    this.radius,
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
        Padding(padding: spacing),
        _buildPart(
          timeStream.map((DateTime time) => time.second),
          startTime.second,
        ),
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
    );
  }

  Widget _buildText(int num) {
    return FlipClockNumItem(
      num: num,
      radius: 2,
    );
  }
}
