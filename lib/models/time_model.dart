class TimeModel {
  final DateTime time;

  TimeModel(this.time);

  String get formattedTime {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}';
  }

  String get formattedDate {
    return '${time.day.toString().padLeft(2, '0')}-${time.month.toString().padLeft(2, '0')}-${time.year.toString()}';
  }

  String get dayOfWeek {
    List<String> daysOfWeek = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
    return daysOfWeek[time.weekday - 1];
  }
}
