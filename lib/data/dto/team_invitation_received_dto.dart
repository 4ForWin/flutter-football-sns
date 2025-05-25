import 'package:mercenaryhub/domain/entity/time_state.dart';

class TeamInvitationReceivedDto {
  final String teamName;
  final String teamId;
  final String feedId;
  final String cost;
  final String person;
  final String level;
  final String imageUrl;
  final String location;
  final String date;
  final TimeState time;
  final String receivedAt;
  final String status;

  TeamInvitationReceivedDto({
    required this.teamName,
    required this.teamId,
    required this.feedId,
    required this.cost,
    required this.person,
    required this.level,
    required this.imageUrl,
    required this.location,
    required this.date,
    required this.time,
    required this.receivedAt,
    required this.status,
  });

  factory TeamInvitationReceivedDto.fromJson(Map<String, dynamic> json) {
    return TeamInvitationReceivedDto(
      teamName: json['teamName'],
      teamId: json['teamId'] ?? json['uid'], // 호환성을 위해
      feedId: json['feedId'],
      cost: json['cost'],
      person: json['person'],
      level: json['level'],
      imageUrl: json['imageUrl'],
      location: json['location'],
      date: json['date'],
      time: TimeState.fromJson(json["time"]),
      receivedAt: json['receivedAt'] ?? json['appliedAt'], // 호환성을 위해
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'teamName': teamName,
      'teamId': teamId,
      'feedId': feedId,
      'cost': cost,
      'person': person,
      'level': level,
      'imageUrl': imageUrl,
      'location': location,
      'date': date,
      'time': time.toJson(),
      'receivedAt': receivedAt,
      'status': status,
    };
  }
}
