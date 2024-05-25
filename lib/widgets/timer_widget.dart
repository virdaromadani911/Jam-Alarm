import 'package:flutter/material.dart';
import 'dart:async';
import '../screens/countdown_screen.dart';  // Correct the import path

class TimerWidget extends StatefulWidget {
  final DateTime selectedTime;

  TimerWidget({required this.selectedTime, Key? key}) : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late TextEditingController _hourController;
  late TextEditingController _minuteController;
  late TextEditingController _secondController;
  late Duration _timerDuration;
  late Timer _timer;
  late int _remainingSeconds;

  @override
  void initState() {
    super.initState();
    _hourController = TextEditingController();
    _minuteController = TextEditingController();
    _secondController = TextEditingController();
    _timerDuration = Duration(hours: 0, minutes: 0, seconds: 0);
    _remainingSeconds = 0;
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    _secondController.dispose();
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _timerDuration = Duration(
        hours: int.parse(_hourController.text.isEmpty ? '0' : _hourController.text),
        minutes: int.parse(_minuteController.text.isEmpty ? '0' : _minuteController.text),
        seconds: int.parse(_secondController.text.isEmpty ? '0' : _secondController.text),
      );
      _remainingSeconds = _timerDuration.inSeconds;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  void _appendDigit(String digit) {
    if (_hourController.text.length < 2) {
      _hourController.text += digit;
    } else if (_minuteController.text.length < 2) {
      _minuteController.text += digit;
    } else if (_secondController.text.length < 2) {
      _secondController.text += digit;
    }
  }

  void _clearInput() {
    _hourController.clear();
    _minuteController.clear();
    _secondController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: 9,
          itemBuilder: (context, index) {
            return ElevatedButton(
              onPressed: () => _appendDigit((index + 1).toString()),
              child: Text((index + 1).toString()),
            );
          },
        ),
        ElevatedButton(
          onPressed: () => _appendDigit('0'),
          child: Text('0'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _startTimer,
          child: Text('Mulai Timer'),
        ),
        SizedBox(height: 20),
        Text(
          'Waktu Tersisa: ${_formatTime(_remainingSeconds)}',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds ~/ 60) % 60;
    int secs = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
}
