import 'package:mercenaryhub/domain/entity/time_state.dart';

class TeamFeedDto {
  String id;
  String cost;
  String person;
  String imageUrl;
  String createAt;
  String teamName;
  String location;
  String level;
  String date;
  TimeState time;
  String content;

  TeamFeedDto({
    required this.id,
    required this.cost,
    required this.person,
    required this.imageUrl,
    required this.createAt,
    required this.teamName,
    required this.location,
    required this.level,
    required this.date,
    required this.time,
    required this.content,
  });

  TeamFeedDto copyWith({
    String? id,
    String? cost,
    String? person,
    String? imageUrl,
    String? createAt,
    String? teamName,
    String? location,
    String? level,
    String? date,
    TimeState? time,
    String? content,
    List<Map<String, bool>>? reactions,
  }) =>
      TeamFeedDto(
        id: id ?? this.id,
        cost: cost ?? this.cost,
        person: person ?? this.person,
        imageUrl: imageUrl ?? this.imageUrl,
        createAt: createAt ?? this.createAt,
        teamName: teamName ?? this.teamName,
        location: location ?? this.location,
        level: level ?? this.level,
        date: date ?? this.date,
        time: time ?? this.time,
        content: content ?? this.content,
      );

  factory TeamFeedDto.fromJson(Map<String, dynamic> json) => TeamFeedDto(
        id: json["id"],
        cost: json["cost"],
        person: json["person"],
        imageUrl: json["imageUrl"],
        createAt: json["createAt"],
        teamName: json["teamName"],
        location: json["location"],
        level: json["level"],
        date: json["date"],
        time: TimeState.fromJson(json["time"]),
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cost": cost,
        "person": person,
        "imageUrl": imageUrl,
        "createAt": createAt,
        "teamName": teamName,
        "location": location,
        "level": level,
        "date": date,
        "time": time.toJson(),
        "content": content,
      };
}
