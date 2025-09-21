import 'package:zentime/DataTypes/work_session.dart';

class DayEntry {
  final DateTime day;
  final List<WorkSession> workSessions;
  final List<WorkSession> breakSessions;
  final bool sick;
  final bool holiday;

  DayEntry({
    required this.day,
    this.workSessions = const [],
    this.breakSessions = const [],
    this.sick = false,
    this.holiday = false,
  });

  Duration getWorkTime() {
    Duration result = Duration.zero;
    for (var workSession in workSessions) {
      result += workSession.getDuration();
    }

    return result;
  }

  Duration getBreakTime() {
    Duration result = Duration.zero;
    for (var breakSession in breakSessions) {
      result += breakSession.getDuration();
    }

    return result;
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day.toIso8601String(),
      'workSessions': workSessions.map((w) => w.toJson()).toList(),
      'breakSessions': breakSessions.map((b) => b.toJson()).toList(),
      'sick': sick,
      'holiday': holiday,
    };
  }

  factory DayEntry.fromJson(Map<String, dynamic> json) {
    return DayEntry(
      day: DateTime.parse(json['day']),
      workSessions: (json['workSessions'] as List)
          .map((w) => WorkSession.fromJson(w))
          .toList(),
      breakSessions: (json['breakSessions'] as List)
          .map((b) => WorkSession.fromJson(b))
          .toList(),
      sick: json['sick'] ?? false,
      holiday: json['holiday'] ?? false,
    );
  }
}
