import 'package:mercenaryhub/data/dto/team_invitation_received_dto.dart';

abstract interface class TeamInvitationReceivedDataSource {
  /// 나를 초대한 팀 목록 조회
  Future<List<TeamInvitationReceivedDto>> fetchTeamInvitations();

  /// 팀 초대 응답 (수락/거절)
  Future<bool> respondToTeamInvitation({
    required String feedId,
    required String response,
  });
}
