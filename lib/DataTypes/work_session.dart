class WorkSession {
  final DateTime start;
  final DateTime end;

  WorkSession({required this.start, required this.end});

  Duration getDuration() {
    return end.difference(start);
  }

  Map<String, dynamic> toJson() {
    return {'start': start.toIso8601String(), 'end': end.toIso8601String()};
  }

  factory WorkSession.fromJson(Map<String, dynamic> json) {
    return WorkSession(
      start: DateTime.parse(json['start']),
      end: DateTime.parse(json['end']),
    );
  }
}
