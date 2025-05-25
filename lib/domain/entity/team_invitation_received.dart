import 'package:mercenaryhub/domain/entity/time_state.dart';

class TeamInvitationReceived {
  final String teamName;
  final String teamId; // 팀 ID (초대한 팀의 사용자 ID)
  final String feedId; // 팀 피드 ID
  final String cost;
  final String person;
  final String level;
  final String imageUrl;
  final String location;
  final DateTime date;
  final TimeState time;
  final DateTime receivedAt; // 초대받은 날짜
  final String status; // pending, accepted, rejected

  TeamInvitationReceived({
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
}
