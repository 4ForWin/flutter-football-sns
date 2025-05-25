import 'package:mercenaryhub/domain/entity/time_state.dart';

class MyMercenaryInvitationHistoryDto {
  final String name;
  final String uid;
  final String feedId;
  final String cost;
  final String level;
  final String imageUrl;
  final String location;
  final String date;
  final TimeState time;
  final String appliedAt;
  final String status;

  MyMercenaryInvitationHistoryDto({
    required this.name,
    required this.uid,
    required this.cost,
    required this.feedId,
    required this.level,
    required this.imageUrl,
    required this.location,
    required this.date,
    required this.time,
    required this.appliedAt,
    required this.status,
  });

  factory MyMercenaryInvitationHistoryDto.fromJson(Map<String, dynamic> json) {
    return MyMercenaryInvitationHistoryDto(
      name: json['name'],
      uid: json['uid'],
      cost: json['cost'],
      feedId: json['feedId'],
      level: json['level'],
      imageUrl: json['imageUrl'],
      location: json['location'],
      date: json['date'],
      time: TimeState.fromJson(json["time"]),
      appliedAt: json['appliedAt'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'uid': uid,
      'cost': cost,
      'feedId': feedId,
      'level': level,
      'imageUrl': imageUrl,
      'location': location,
      'date': date,
      'time': time,
      'appliedAt': appliedAt,
      'status': status,
    };
  }
}
