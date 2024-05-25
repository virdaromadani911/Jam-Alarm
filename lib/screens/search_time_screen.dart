import 'package:flutter/material.dart';

// Model data waktu negara
class CountryTime {
  final String country;
  final String time;

  CountryTime(this.country, this.time);
}

class SearchTimeScreen extends StatelessWidget {
  final List<CountryTime> countryTimes = [
    CountryTime('Indonesia', '10:00:00'),
    CountryTime('United States', '12:30:45'),
    CountryTime('United Kingdom', '23:15:20'),
    // Tambahkan negara dan waktu negara lainnya di sini
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pencarian Waktu'),
      ),
      body: ListView.builder(
        itemCount: countryTimes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              '${countryTimes[index].country} - ${countryTimes[index].time}',
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              Navigator.pop(context, countryTimes[index].time);
            },
          );
        },
      ),
    );
  }
}
