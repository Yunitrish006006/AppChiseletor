import 'dart:async';

import 'package:flutter/material.dart';

class ClockWidget extends StatefulWidget {
  final Color color;
  const ClockWidget({super.key, required this.color});

  @override
  State<ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  late DateTime _currentTime;

  @override
  void initState() {
    updateTime();
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      updateTime();
    });
  }

  updateTime() {
    setState(() {
      _currentTime = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        // Display the current time in HH:MM:SS format
        '${_currentTime.hour.toString().padLeft(2, '0')}:${_currentTime.minute.toString().padLeft(2, '0')}:${_currentTime.second.toString().padLeft(2, '0')}',
        style: TextStyle(
          color: widget.color,
          fontSize: 48,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
