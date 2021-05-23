import 'package:flip_clock/widget/flip_board.dart';
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                FlipBoard<int>(
                  curves: Curves.easeInQuint,
                  itemBuilder: (_, value) {
                    return _buildText(value);
                  },
                  stream: Stream<int>.periodic(Duration(seconds: 1), (x) => x)
                      .take(60),
                  initValue: 0,
                ),
                Padding(padding: EdgeInsets.all(8)),
                FlipBoard<int>(
                  curves: Curves.easeInQuint,
                  itemBuilder: (_, value) {
                    return _buildText(value);
                  },
                  stream: Stream<int>.periodic(Duration(seconds: 1), (x) => x)
                      .take(60),
                  initValue: 0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildText(int num) {
    return FlipClockNumItem(
      num: num,
      radius: 2,
    );
  }
}
