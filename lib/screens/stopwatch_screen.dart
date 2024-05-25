import 'package:flutter/material.dart';
import 'dart:async'; // Import untuk mengakses kelas Timer

class StopwatchScreen extends StatefulWidget {
  @override
  _StopwatchScreenState createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  String _elapsedTime = '00:00'; // Waktu awal, hanya menit dan detik
  List<String> recordedTimes = []; // Daftar waktu yang sudah dicatat

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _elapsedTime = _formatTime(_stopwatch.elapsed.inSeconds);
      });
    });
  }

  String _formatTime(int seconds) {
    if (seconds >= 60) {
      int minutes = (seconds / 60).truncate();
      seconds = seconds % 60;
      return '$minutes:${seconds.toString().padLeft(2, '0')}';
    } else {
      return '00:${seconds.toString().padLeft(2, '0')}';
    }
  }

  void _recordTime() {
    recordedTimes.add(_elapsedTime);
  }

  void _resetStopwatch() {
    _stopwatch.reset();
    setState(() {
      _elapsedTime = '00:00';
      recordedTimes.clear(); // Hapus semua catatan waktu saat reset
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stopwatch'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _elapsedTime,
              style: TextStyle(fontSize: 48),
            ),
            SizedBox(height: 20),
            if (!_stopwatch.isRunning) // Tombol Play hanya muncul jika stopwatch tidak berjalan
              ElevatedButton(
                onPressed: () {
                  _stopwatch.start();
                  _startTimer();
                },
                child: Icon(Icons.play_arrow),
              ),
            if (_stopwatch.isRunning) // Tombol Stop, Reset, dan Catat Waktu muncul jika stopwatch berjalan
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _resetStopwatch,
                    child: Icon(Icons.refresh),
                  ),                  
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      _stopwatch.stop();
                      _timer?.cancel();
                    },
                    child: Icon(Icons.pause),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _recordTime,
                    child: Icon(Icons.note),
                  ),
                ],
              ),
            SizedBox(height: 20),
            if (recordedTimes.isNotEmpty) // Tampilkan waktu yang sudah dicatat di bawah Stopwatch
              Column(
                children: recordedTimes.map((time) => Text(time)).toList(),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _stopwatch.stop();
    _timer?.cancel();
    super.dispose();
  }
}
