import 'package:flutter/material.dart';
import 'countdown_screen.dart';  // Import layar hitungan mundur

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  final TextEditingController _hoursController = TextEditingController(text: '00');
  final TextEditingController _minutesController = TextEditingController(text: '00');
  final TextEditingController _secondsController = TextEditingController(text: '00');

  @override
  void dispose() {
    _hoursController.dispose();
    _minutesController.dispose();
    _secondsController.dispose();
    super.dispose();
  }

  void _startCountdown() {
    int hours = int.tryParse(_hoursController.text) ?? 0;
    int minutes = int.tryParse(_minutesController.text) ?? 0;
    int seconds = int.tryParse(_secondsController.text) ?? 0;
    int totalSeconds = hours * 3600 + minutes * 60 + seconds;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CountdownScreen(totalSeconds: totalSeconds),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Timer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: TextField(
                        controller: _hoursController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          suffixText: 'hrs',
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: TextField(
                        controller: _minutesController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          suffixText: 'min',
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: TextField(
                        controller: _secondsController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          suffixText: 'sec',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
            IconButton(
              onPressed: _startCountdown,
              icon: Icon(Icons.play_arrow),
              iconSize: 40,
            ),
          ],
        ),
      ),
    );
  }
}