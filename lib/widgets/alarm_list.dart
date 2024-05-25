import 'package:flutter/material.dart';

class AlarmList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5, // Ganti dengan jumlah alarm yang sebenarnya
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.alarm),
          title: Text('Alarm ${index + 1}'),
          subtitle: Text('07:00 AM'), // Ganti dengan waktu alarm yang sebenarnya
          trailing: Icon(Icons.delete),
        );
      },
    );
  }
}
