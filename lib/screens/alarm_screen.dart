import 'package:flutter/material.dart';
import '../models/alarm.dart';
import '../services/alarm_service.dart';

class AlarmScreen extends StatefulWidget {
  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  final AlarmService _alarmService = AlarmService();
  bool isAlarmOn = false; // Tambahkan variabel untuk status alarm
  Set<String> selectedDays = {}; // Tambahkan variabel untuk menyimpan hari alarm yang dipilih

  void _toggleAlarm(bool value) {
    setState(() {
      isAlarmOn = value;
    });
  }

  void _selectDay(String day) {
    setState(() {
      if (selectedDays.contains(day)) {
        selectedDays.remove(day);
      } else {
        selectedDays.add(day);
      }
    });
  }

  void _deleteAlarm() {
    // Implementasi logika penghapusan alarm
  }

  void _startCountdown() {
    // Implementasi logika memulai hitungan mundur
  }

  @override
  Widget build(BuildContext context) {
    List<Alarm> alarms = _alarmService.getAlarms();

    return Scaffold(
      appBar: AppBar(
        title: Text('Alarm'),
      ),
      body: ListView.builder(
        itemCount: alarms.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.alarm),
            title: Text('Alarm ${index + 1}'),
            subtitle: Text(alarms[index].time.format(context)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Switch(
                  value: isAlarmOn,
                  onChanged: _toggleAlarm,
                ),
                IconButton(
                  onPressed: _deleteAlarm,
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          TimeOfDay? selectedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );

          if (selectedTime != null) {
            Alarm newAlarm = Alarm(selectedTime);
            _alarmService.addAlarm(newAlarm);
            setState(() {}); // Update tampilan setelah menambahkan alarm
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
