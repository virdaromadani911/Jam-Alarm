import 'package:flutter/material.dart';
import '../services/clock_service.dart';
import '../models/time_model.dart';
import 'search_time_screen.dart';

class ClockScreen extends StatefulWidget {
  @override
  _ClockScreenState createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  late ClockService _clockService;
  List<String> selectedTimeZones = [];

  @override
  void initState() {
    super.initState();
    _clockService = ClockService();
    // Initialize time zones here if needed
    _initializeTimeZones();
  }

  // Method to initialize time zones
  void _initializeTimeZones() {
    // Add default time zones or load from storage if needed
    selectedTimeZones.addAll(['Asia/Jakarta', 'America/New_York']);
  }

  @override
  void dispose() {
    _clockService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jam'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<TimeModel>(
              stream: _clockService.currentTimeStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${snapshot.data!.formattedTime}',
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '${snapshot.data!.dayOfWeek}, ${snapshot.data!.formattedDate}',
                        style: TextStyle(fontSize: 20),
                      ),
                      if (selectedTimeZones.isNotEmpty)
                        ...selectedTimeZones.map((timeZone) {
                          final timeModel = _clockService.getTimeForTimeZone(timeZone);
                          return ListTile(
                            title: Text(
                              'Waktu di $timeZone: ${timeModel.formattedTime}',
                              style: TextStyle(fontSize: 20),
                            ),
                            subtitle: Text(
                              '${timeModel.dayOfWeek}, ${timeModel.formattedDate}',
                              style: TextStyle(fontSize: 16),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  selectedTimeZones.remove(timeZone);
                                });
                              },
                            ),
                          );
                        }).toList(),
                    ],
                  );
                } else {
                  return Text('Loading...');
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // This will trigger a rebuild and update the UI
                });
              },
              child: Text('Perbarui Waktu'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final selectedTimeZone = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchTimeScreen()),
          );
          if (selectedTimeZone != null) {
            setState(() {
              selectedTimeZones.add(selectedTimeZone);
            });
          }
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
