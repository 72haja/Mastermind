import 'dart:async';

import 'package:flutter/material.dart';

class StopWatchWidget extends StatefulWidget {
  const StopWatchWidget({Key? key}) : super(key: key);

  @override
  StopWatchWidgetState createState() => StopWatchWidgetState();
}

class StopWatchWidgetState extends State<StopWatchWidget> {
  Duration duration = const Duration();

  Timer? timer;

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override
  void dispose() {
    super.dispose();

    stopTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      addTime();
    });
  }

  String stopTimer() {
    timer?.cancel();
    return '${duration.inSeconds}';
  }

  void addTime() {
    const addSeconds = 1;

    setState(() {
      final seconds = duration.inSeconds + addSeconds;

      duration = Duration(seconds: seconds);
    });
  }

  String twoDigits(int n) => n.toString().padLeft(2, '0');

  get hours => twoDigits(duration.inHours.remainder(60));
  get minutes => twoDigits(duration.inMinutes.remainder(60));
  get seconds => twoDigits(duration.inSeconds.remainder(60));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      child: SizedBox(
        width: 90,
        child: GestureDetector(
          onTap: () => stopTimer(),
          child: buildTime(),
        ),
      ),
    );
  }

  Widget buildTime() {
    return Text(
      '$hours:$minutes:$seconds',
      style: const TextStyle(fontSize: 20),
    );
  }
}
