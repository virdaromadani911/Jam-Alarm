import 'package:flutter/material.dart';

class SearchTimeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Time Zone'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pilih Zona Waktu',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 'Asia/Jakarta');
              },
              child: Text('Asia/Jakarta'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 'America/New_York');
              },
              child: Text('America/New_York'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 'Europe/London');
              },
              child: Text('Europe/London'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 'Australia/Sydney');
              },
              child: Text('Australia/Sydney'),
            ),
          ],
        ),
      ),
    );
  }
}
