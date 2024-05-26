import 'package:flutter/material.dart';
import 'countdown_screen.dart';  // Import layar hitungan mundur

class Timer {
  final String name;
  final int totalSeconds;

  Timer({required this.name, required this.totalSeconds});
}

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  List<Timer> timers = [];

  void _addTimer(String name, int hours, int minutes, int seconds) {
    int totalSeconds = hours * 3600 + minutes * 60 + seconds;

    setState(() {
      timers.add(Timer(name: name, totalSeconds: totalSeconds));
    });
  }

  void _startCountdown(Timer timer) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CountdownScreen(
          totalSeconds: timer.totalSeconds,
          timerName: timer.name,
        ),
      ),
    );
  }

  void _deleteTimer(int index) {
    setState(() {
      timers.removeAt(index);
    });
  }

  Future<void> _showAddTimerDialog() async {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController hoursController = TextEditingController(text: '00');
    final TextEditingController minutesController = TextEditingController(text: '00');
    final TextEditingController secondsController = TextEditingController(text: '00');

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Timer'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Timer Name',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: TextField(
                        controller: hoursController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          suffixText: 'hrs',
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: TextField(
                        controller: minutesController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          suffixText: 'min',
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: TextField(
                        controller: secondsController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          suffixText: 'sec',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                String name = nameController.text;
                int hours = int.tryParse(hoursController.text) ?? 0;
                int minutes = int.tryParse(minutesController.text) ?? 0;
                int seconds = int.tryParse(secondsController.text) ?? 0;
                _addTimer(name, hours, minutes, seconds);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timers'),
      ),
      body: ListView.builder(
        itemCount: timers.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(timers[index].name),
            onDismissed: (direction) {
              _deleteTimer(index);
            },
            background: Container(color: Colors.red),
            child: ListTile(
              title: Text(timers[index].name),
              subtitle: Text('${timers[index].totalSeconds} seconds'),
              trailing: IconButton(
                icon: Icon(Icons.play_arrow),
                onPressed: () => _startCountdown(timers[index]),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTimerDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
