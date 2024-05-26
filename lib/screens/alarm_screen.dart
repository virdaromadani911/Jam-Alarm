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

  void _toggleAlarm(Alarm alarm, bool value) {
    setState(() {
      alarm.isActive = value;
      _alarmService.updateAlarm(alarm);
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

  void _deleteAlarm(int index) {
    _alarmService.removeAlarm(index);
    setState(() {}); // Update tampilan setelah menghapus alarm
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
                  value: alarms[index].isActive,
                  onChanged: (value) {
                    _toggleAlarm(alarms[index], value);
                  },
                ),
                IconButton(
                  onPressed: () => _deleteAlarm(index),
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
            onTap: () {
              // Logika untuk memilih hari alarm
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Pilih Hari'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu']
                          .map((day) => CheckboxListTile(
                                title: Text(day),
                                value: selectedDays.contains(day),
                                onChanged: (isSelected) {
                                  _selectDay(day);
                                  Navigator.of(context).pop();
                                },
                              ))
                          .toList(),
                    ),
                  );
                },
              );
            },
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
            Alarm newAlarm = Alarm(time: selectedTime, isActive: true, activeDays: selectedDays.toList());
            _alarmService.addAlarm(newAlarm);
            setState(() {}); // Update tampilan setelah menambahkan alarm
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
