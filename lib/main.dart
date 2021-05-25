import 'package:flip_clock/widget/flip_board.dart';
import 'package:flip_clock/widget/flip_clock.dart';
import 'package:flip_clock/widget/flip_clock_num_item.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: FlipClock(
              startTime: DateTime.now(),
            ),
          ),
        ),
      ),
    );
  }

}
