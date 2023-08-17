import 'package:flutter/material.dart';
import 'dart:async';

class AnimationScreen extends StatefulWidget {
  @override
  _AnimationScreenState createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen>
    with SingleTickerProviderStateMixin {
  List<int> yvals1 = [];
  List<int> yvals2 = [];
  int currentIndex = 0;
  late Timer timer;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    loadTextData();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..addListener(() {
      setState(() {
        // Empty setState to trigger rebuild
      });
    });
    _animationController.repeat();
  }

  @override
  void dispose() {
    timer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void loadTextData() async {
    final textFile1Path = 'assets/test.csv';
    final textFile2Path = 'assets/test2.csv';
    final lines1 =
    await DefaultAssetBundle.of(context).loadString(textFile1Path);
    final lines2 =
    await DefaultAssetBundle.of(context).loadString(textFile2Path);

    setState(() {
      yvals1 = parseTextLines(lines1);
      yvals2 = parseTextLines(lines2);
    });

    startTimer(); // Start the timer after loading the text data
  }

  List<int> parseTextLines(String lines) {
    final values =
    lines.split(',').map(int.tryParse).whereType<int>().toList();
    return values;

  }

  void startTimer() {
    const duration = Duration(milliseconds: 10);
    timer = Timer.periodic(duration, (timer) {
      try {
        setState(() {
          currentIndex++;
          if (currentIndex >= yvals1.length || currentIndex >= yvals2.length) {
            timer.cancel();
          }
          currentIndex %= yvals1.length; // Wrap around the index if it exceeds the list length
        });
      } catch (e) {
        timer.cancel();
        // Handle or log the error if necessary
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation Screen'),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, _) {
            return AnimatedPlot(
              yvals1: yvals1,
              yvals2: yvals2,
              currentIndex: currentIndex,
            );
          },
        ),
      ),
    );
  }
}

class AnimatedPlot extends StatelessWidget {
  final List<int>? yvals1;
  final List<int>? yvals2;
  final int currentIndex;

  AnimatedPlot({this.yvals1, this.yvals2, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final normalizedYVal1 =
    yvals1 != null && yvals1!.isNotEmpty
        ? (yvals1![currentIndex] -
        yvals1!.reduce((min, value) => min < value ? min : value)) /
        (yvals1!.reduce((max, value) => max > value ? max : value) -
            yvals1!.reduce((min, value) => min < value ? min : value))
        : 0.0;

    final normalizedYVal2 =
    yvals2 != null && yvals2!.isNotEmpty
        ? (yvals2![currentIndex] -
        yvals2!.reduce((min, value) => min < value ? min : value)) /
        (yvals2!.reduce((max, value) => max > value ? max : value) -
            yvals2!.reduce((min, value) => min < value ? min : value))
        : 0.0;

    final xStart1 = 220;
    final xEnd1 = 250;
    final yStart1 = 130;
    final yEnd1 = 160;

    final xStart2 = 260;
    final xEnd2 = 290;
    final yStart2 = 130;
    final yEnd2 = 160;

    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'images/body.png',
            fit: BoxFit.cover,
          ),
        ),
        if (yvals1 != null && yvals1!.isNotEmpty)
          Positioned(
            left: xStart1.toDouble(),
            top: yStart1.toDouble(),
            right: xEnd1.toDouble(),
            bottom: yEnd1.toDouble(),
            child: Container(
              color: getColorFromNormalizedValue(normalizedYVal1),
            ),
          ),
        if (yvals2 != null && yvals2!.isNotEmpty)
          Positioned(
            left: xStart2.toDouble(),
            top: yStart2.toDouble(),
            right: xEnd2.toDouble(),
            bottom: yEnd2.toDouble(),
            child: Container(
              color: getColorFromNormalizedValue(normalizedYVal2),
            ),
          ),
      ],
    );
  }

  Color getColorFromNormalizedValue(double normalizedValue) {
    final color = ColorTween(
      begin: Colors.yellow,
      end: Colors.red,
    ).transform(normalizedValue);

    return color ?? Colors.green;
  }
}
