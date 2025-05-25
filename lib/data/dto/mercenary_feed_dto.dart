import 'package:mercenaryhub/domain/entity/time_state.dart';

class MercenaryFeedDto {
  String id;
  String cost;
  String imageUrl;
  String createAt;
  String name;
  String location;
  String level;
  String date;
  TimeState time;
  String content;

  MercenaryFeedDto({
    required this.id,
    required this.cost,
    required this.imageUrl,
    required this.createAt,
    required this.name,
    required this.location,
    required this.level,
    required this.date,
    required this.time,
    required this.content,
  });

  MercenaryFeedDto copyWith({
    String? id,
    String? cost,
    String? imageUrl,
    String? createAt,
    String? name,
    String? location,
    String? level,
    String? date,
    TimeState? time,
    String? content,
  }) =>
      MercenaryFeedDto(
        id: id ?? this.id,
        cost: cost ?? this.cost,
        imageUrl: imageUrl ?? this.imageUrl,
        createAt: createAt ?? this.createAt,
        name: name ?? this.name,
        location: location ?? this.location,
        level: level ?? this.level,
        date: date ?? this.date,
        time: time ?? this.time,
        content: content ?? this.content,
      );

  factory MercenaryFeedDto.fromJson(Map<String, dynamic> json) =>
      MercenaryFeedDto(
        id: json["id"],
        cost: json["cost"],
        imageUrl: json["imageUrl"],
        createAt: json["createAt"],
        name: json["name"],
        location: json["location"],
        level: json["level"],
        date: json["date"],
        time: TimeState.fromJson(json["time"]),
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cost": cost,
        "imageUrl": imageUrl,
        "createAt": createAt,
        "name": name,
        "location": location,
        "level": level,
        "date": date,
        "time": time.toJson(),
        "content": content,
      };
}
