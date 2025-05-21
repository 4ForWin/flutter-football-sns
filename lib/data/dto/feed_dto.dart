import 'package:mercenaryhub/domain/entity/time_state.dart';

class FeedDto {
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

  FeedDto({
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
  });

  FeedDto copyWith({
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
  }) =>
      FeedDto(
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
      );

  factory FeedDto.fromJson(Map<String, dynamic> json) => FeedDto(
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
      };
}
