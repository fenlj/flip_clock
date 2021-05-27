import 'package:flip_clock/widget/flip_clock.dart';
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
        primarySwatch: Colors.amber,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Flip Clock'),),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FlipClock(
                startTime: DateTime.now(),
                radius: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
