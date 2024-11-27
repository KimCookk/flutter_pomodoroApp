import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const int setTotalSeconds = 10;

  int seconds = setTotalSeconds;
  int completePomodors = 0;

  bool isPlaying = false;
  late Timer timer;

  onTick(Timer timer) {
    if (seconds == 0) {
      setState(() {
        seconds = setTotalSeconds;
        isPlaying = false;
        timer.cancel();
        completePomodors = completePomodors + 1;
      });
    } else {
      setState(() {
        seconds = seconds - 1;
      });
    }
  }

  onPressedButton() {
    if (!isPlaying) {
      timer = Timer.periodic(const Duration(seconds: 1), onTick);
    } else {
      timer.cancel();
    }

    setState(() {
      isPlaying = !isPlaying;
    });
  }

  String formattedSeconds() {
    return Duration(seconds: seconds).toString().split('.')[0].substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          children: [
            Flexible(
              flex: 3,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  formattedSeconds(),
                  style: TextStyle(
                    color: Theme.of(context).cardColor,
                    fontSize: 100,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 4,
              child: Center(
                child: IconButton(
                  onPressed: () => {onPressedButton()},
                  color: Theme.of(context).cardColor,
                  icon: Icon(
                    isPlaying
                        ? Icons.pause_circle_outline
                        : Icons.play_circle_outline_rounded,
                    size: 150,
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pomodoros',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color:
                                Theme.of(context).textTheme.displayLarge?.color,
                          ),
                        ),
                        Text(
                          '$completePomodors',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            color:
                                Theme.of(context).textTheme.displayLarge?.color,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
