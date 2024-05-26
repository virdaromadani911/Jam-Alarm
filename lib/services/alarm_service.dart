import '../models/alarm.dart';

class AlarmService {
  final List<Alarm> _alarms = [];

  List<Alarm> getAlarms() {
    return _alarms;
  }

  void addAlarm(Alarm alarm) {
    _alarms.add(alarm);
  }

  void removeAlarm(int index) {
    _alarms.removeAt(index);
  }

  void updateAlarm(Alarm alarm) {
    for (int i = 0; i < _alarms.length; i++) {
      if (_alarms[i].time == alarm.time) {
        _alarms[i] = alarm;
        break;
      }
    }
  }
}

