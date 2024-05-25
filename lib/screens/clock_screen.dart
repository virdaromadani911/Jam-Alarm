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
  List<String> selectedCountryTimes = [];

  @override
  void initState() {
    super.initState();
    _clockService = ClockService();
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

                      if (selectedCountryTimes.isNotEmpty) ...selectedCountryTimes.map((time) => 
                        ListTile(
                          title: Text(
                            'Waktu Negara yang Dipilih: $time',
                            style: TextStyle(fontSize: 20),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                selectedCountryTimes.remove(time);
                              });
                            },
                          ),
                        )
                      ).toList(),
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
                _clockService.updateTime();
              },
              child: Text('Perbarui Waktu'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final selectedTime = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchTimeScreen()),
          );
          if (selectedTime != null) {
            setState(() {
              selectedCountryTimes.add(selectedTime);
            });
          }
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
