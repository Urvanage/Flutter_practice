import 'package:flutter/material.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const twentyFiveMinutes = 1500;
  int totalSeconds = twentyFiveMinutes;
  late Timer timer;
  int totalPomodors = 0;
  bool isRunning = false;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalPomodors++;
        isRunning = false;
        totalSeconds = twentyFiveMinutes;
      });
    } else {
      setState(() {
        totalSeconds--;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onRestartPressed() {
    setState(() {
      isRunning = false;
      totalSeconds = twentyFiveMinutes;
      timer.cancel();
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
              flex: 1,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  format(totalSeconds),
                  style: TextStyle(
                      color: Theme.of(context).cardColor,
                      fontSize: 89,
                      fontWeight: FontWeight.w600),
                ),
              )),
          Flexible(
              flex: 3,
              child: Center(
                  child: Column(
                children: [
                  IconButton(
                    iconSize: 120,
                    color: Theme.of(context).cardColor,
                    onPressed: isRunning ? onPausePressed : onStartPressed,
                    icon: Icon(!isRunning
                        ? Icons.play_circle_outline
                        : Icons.pause_circle_outline),
                  ),
                  IconButton(
                      iconSize: 50,
                      color: Theme.of(context).cardColor,
                      onPressed: onRestartPressed,
                      icon: const Icon(Icons.restart_alt_outlined))
                ],
              ))),
          Flexible(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Pomodors',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff232f55)),
                            ),
                            Text(
                              '$totalPomodors',
                              style: const TextStyle(
                                  fontSize: 58,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff232f55)),
                            ),
                          ],
                        )),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
