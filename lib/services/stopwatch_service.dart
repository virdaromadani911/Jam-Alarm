import 'dart:async';

class StopwatchService {
  Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;
  bool _isRunning = false;

  void start() {
    if (!_isRunning) {
      _stopwatch.start();
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        // Update UI or perform other tasks every second
      });
      _isRunning = true;
    }
  }

  void stop() {
    if (_isRunning) {
      _stopwatch.stop();
      _timer?.cancel();
      _isRunning = false;
    }
  }

  Duration get elapsedTime => _stopwatch.elapsed;

  bool get isRunning => _isRunning;
}
