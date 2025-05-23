class TimeState {
  DateTime? start;
  DateTime? end;

  TimeState({
    this.start,
    this.end,
  });

  TimeState copyWith({
    DateTime? start,
    DateTime? end,
  }) {
    return TimeState(
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  TimeState.fromJson(Map<String, dynamic> json)
      : this(
          start: DateTime.parse(json['start']),
          end: DateTime.parse(json['end']),
        );

  Map<String, dynamic> toJson() {
    return {
      'start': start!.toIso8601String(),
      'end': end!.toIso8601String(),
    };
  }
}
