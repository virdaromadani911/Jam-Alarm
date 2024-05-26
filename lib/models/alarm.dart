import 'package:flutter/material.dart';

class Alarm {
  TimeOfDay time;
  bool isActive;
  List<String> activeDays;

  Alarm({required this.time, this.isActive = false, this.activeDays = const []});
}

