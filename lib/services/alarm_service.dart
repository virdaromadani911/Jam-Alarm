import '../models/alarm.dart';

class AlarmService {
  List<Alarm> _alarms = [];

  List<Alarm> getAlarms() {
    return _alarms;
  }

  void addAlarm(Alarm alarm) {
    _alarms.add(alarm);
  }

  void removeAlarm(int index) {
    if (index >= 0 && index < _alarms.length) {
      _alarms.removeAt(index);
    }
  }
}
