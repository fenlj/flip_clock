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

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {


  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

