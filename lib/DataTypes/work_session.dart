class WorkSession {
  final DateTime start;
  final DateTime end;

  WorkSession({required this.start, required this.end});

  Duration getDuration() {
    return end.difference(start);
  }
}
