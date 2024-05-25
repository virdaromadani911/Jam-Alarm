import 'dart:async';
import '../models/time_model.dart';

class ClockService {
  final _currentTimeController = StreamController<TimeModel>();
  Stream<TimeModel> get currentTimeStream => _currentTimeController.stream;

  ClockService() {
    _updateTime();
  }

  void _updateTime() {
    final currentTime = DateTime.now();
    final timeModel = TimeModel(currentTime);
    _currentTimeController.add(timeModel);
  }

  void updateTime() {
    _updateTime();
  }

  void updateDate() {
    _updateTime();
  }

  void dispose() {
    _currentTimeController.close();
  }
}
