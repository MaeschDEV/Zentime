import 'package:hive_flutter/hive_flutter.dart';
import 'package:zentime/DataTypes/day_entry.dart';

class DayRepository {
  final box = Hive.box('days');

  void saveDay(DayEntry entry) {
    box.put(entry.day.toIso8601String(), entry.toJson());
  }

  DayEntry? getDay(DateTime date) {
    final data = box.get(date.toIso8601String());
    if (data == null) {
      return null;
    }
    return DayEntry.fromJson(Map<String, dynamic>.from(data));
  }

  List<DayEntry> getAllDays() {
    return box.values
        .map((e) => DayEntry.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
}
