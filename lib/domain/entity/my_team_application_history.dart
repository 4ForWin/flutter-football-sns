import 'package:mercenaryhub/domain/entity/time_state.dart';

class MyTeamApplicationHistory {
  final String teamName;
  final String uid; // 피드 작성한 유저의 id
  final String feedId; // 피드 id
  final String cost;
  final String level;
  final String imageUrl;
  final String location;
  final DateTime date;
  final TimeState time;
  final DateTime appliedAt;
  final String status; // pending, accepted, rejected

  MyTeamApplicationHistory({
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
}
