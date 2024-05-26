import 'package:flutter/material.dart';
import 'dart:async';  // Untuk Timer

class CountdownScreen extends StatefulWidget {
  final int totalSeconds;
  final String timerName;

  CountdownScreen({required this.totalSeconds, required this.timerName});

  @override
  _CountdownScreenState createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen> {
  late int _remainingSeconds;
  late Timer _timer;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.totalSeconds;
    _startCountdown();
  }

  void _startCountdown() {
    _isRunning = true;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _timer.cancel();
          _isRunning = false;
        }
      });
    });
  }

  void _stopTimer() {
    _timer.cancel();
    setState(() {
      _isRunning = false;
    });
  }

  void _resumeTimer() {
    _startCountdown();
  }

  void _resetTimer() {
    _stopTimer();
    setState(() {
      _remainingSeconds = widget.totalSeconds;
    });
    _startCountdown();
  }

  void _deleteTimer() {
    _stopTimer();
    Navigator.pop(context);
  }

  void _addTime(int seconds) {
    setState(() {
      _remainingSeconds += seconds;
    });
  }

  double get progress => _remainingSeconds / widget.totalSeconds;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.timerName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 200, // Adjust the width of the circle as needed
                  height: 200, // Adjust the height of the circle as needed
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 10.0,
                  ),
                ),
                Text(
                  '${(_remainingSeconds ~/ 3600).toString().padLeft(2, '0')}:${((_remainingSeconds % 3600) ~/ 60).toString().padLeft(2, '0')}:${(_remainingSeconds % 60).toString().padLeft(2, '0')}',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
            IconButton(
              onPressed: _resetTimer,
              icon: Icon(Icons.restore),
              iconSize: 40,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: _deleteTimer,
                  icon: Icon(Icons.delete),
                  iconSize: 40,
                ),
                IconButton(
                  onPressed: _isRunning ? _stopTimer : _resumeTimer,
                  icon: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
                  iconSize: 40,
                ),
                IconButton(
                  onPressed: () => _addTime(60), // Add 1 minute
                  icon: Icon(Icons.add_circle),
                  iconSize: 40,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
