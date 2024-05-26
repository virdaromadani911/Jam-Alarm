import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../models/time_model.dart';
import 'dart:async';
import 'dart:core';
import 'package:flutter/foundation.dart';


class ClockService {
  late StreamController<TimeModel> _timeController;
  late tz.Location _location;

  ClockService() {
    _timeController = StreamController<TimeModel>();
    tz.initializeTimeZones();
    _location = tz.getLocation('Asia/Jakarta'); // Default location, change as needed
    _startClock();
  }

  void _startClock() {
    Timer.periodic(Duration(seconds: 1), (_) {
      _updateTime();
    });
  }

  void _updateTime() {
    final now = tz.TZDateTime.now(_location);
    final formattedTime = DateFormat('HH:mm:ss').format(now);
    final formattedDate = DateFormat('yyyy-MM-dd').format(now);
    final dayOfWeek = DateFormat('EEEE').format(now);

    final timeModel = TimeModel(
      formattedTime: formattedTime,
      formattedDate: formattedDate,
      dayOfWeek: dayOfWeek,
    );

    _timeController.add(timeModel);
  }

  Stream<TimeModel> get currentTimeStream => _timeController.stream;

  TimeModel getTimeForTimeZone(String timeZone) {
    final tz.Location location = tz.getLocation(timeZone);
    final now = tz.TZDateTime.now(location);
    final formattedTime = DateFormat('HH:mm:ss').format(now);
    final formattedDate = DateFormat('yyyy-MM-dd').format(now);
    final dayOfWeek = DateFormat('EEEE').format(now);

    return TimeModel(
      formattedTime: formattedTime,
      formattedDate: formattedDate,
      dayOfWeek: dayOfWeek,
    );
  }

  void dispose() {
    _timeController.close();
  }
}
