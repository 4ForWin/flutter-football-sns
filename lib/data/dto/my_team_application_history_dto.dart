import 'package:mercenaryhub/domain/entity/time_state.dart';

class MyTeamApplicationHistoryDto {
  final String? applicationId; // 고유 ID 추가
  final String teamName;
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

  MyTeamApplicationHistoryDto({
    this.applicationId, // nullable로 설정 (기존 데이터 호환성)
    required this.teamName,
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

  factory MyTeamApplicationHistoryDto.fromJson(Map<String, dynamic> json) {
    return MyTeamApplicationHistoryDto(
      applicationId: json['applicationId'], // nullable이므로 null일 수 있음
      teamName: json['teamName'],
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
      if (applicationId != null) 'applicationId': applicationId,
      'teamName': teamName,
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
