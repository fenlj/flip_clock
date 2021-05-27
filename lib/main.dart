import 'package:flip_clock/widget/flip_board.dart';
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
      home: IntroductionPage(),
    );
  }
}

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  late bool _isShowSeconds;
  late bool _isFlipUp;

  @override
  void initState() {
    super.initState();
    _isShowSeconds = true;
    _isFlipUp = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flip Clock'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FlipClock(
              startTime: DateTime.now(),
              showSeconds: _isShowSeconds,
              flipDirection: _isFlipUp ? FlipDirection.up : FlipDirection.down,
            ),
            SizedBox(height: 48),
            SwitchListTile(
              title: Text('Whether to show seconds：'),
              value: _isShowSeconds,
              onChanged: (value) {
                setState(() {
                  _isShowSeconds = value;
                });
              },
            ),
            SizedBox(height: 16),
            SwitchListTile(
              title: Text('Whether to flip up：'),
              value: _isFlipUp,
              onChanged: (value) {
                setState(() {
                  _isFlipUp = value;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
