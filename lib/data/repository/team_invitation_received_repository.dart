import 'package:mercenaryhub/domain/entity/team_invitation_received.dart';

abstract interface class TeamInvitationReceivedRepository {
  /// 나를 초대한 팀 목록 조회
  Future<List<TeamInvitationReceived>> fetchTeamInvitations();

  /// 팀 초대 응답 (수락/거절)
  Future<bool> respondToTeamInvitation({
    required String feedId,
    required String response, // 'accepted' or 'rejected'
  });
}
