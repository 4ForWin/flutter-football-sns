import 'package:mercenaryhub/data/data_source/team_invitation_received_data_source.dart';
import 'package:mercenaryhub/data/repository/team_invitation_received_repository.dart';
import 'package:mercenaryhub/domain/entity/team_invitation_received.dart';

class TeamInvitationReceivedRepositoryImpl
    implements TeamInvitationReceivedRepository {
  final TeamInvitationReceivedDataSource _dataSource;

  TeamInvitationReceivedRepositoryImpl(this._dataSource);

  @override
  Future<List<TeamInvitationReceived>> fetchTeamInvitations() async {
    try {
      print('🚕 Repository: fetchTeamInvitations 호출');
      final dtoList = await _dataSource.fetchTeamInvitations();
      print('🚕 Repository: ${dtoList.length}개의 팀 초대 내역 조회');

      return dtoList.map((dto) {
        return TeamInvitationReceived(
          teamName: dto.teamName,
          teamId: dto.teamId,
          feedId: dto.feedId,
          cost: dto.cost,
          person: dto.person,
          level: dto.level,
          imageUrl: dto.imageUrl,
          location: dto.location,
          date: DateTime.parse(dto.date),
          time: dto.time,
          receivedAt: DateTime.parse(dto.receivedAt),
          status: dto.status,
        );
      }).toList();
    } catch (e) {
      print('❌ Repository fetchTeamInvitations error: $e');
      return [];
    }
  }

  @override
  Future<bool> respondToTeamInvitation({
    required String feedId,
    required String response,
  }) async {
    try {
      print(
          '🚕 Repository: respondToTeamInvitation 호출 - feedId: $feedId, response: $response');
      final result = await _dataSource.respondToTeamInvitation(
        feedId: feedId,
        response: response,
      );
      print('🚕 Repository: 팀 초대 응답 완료');
      return result;
    } catch (e) {
      print('❌ Repository respondToTeamInvitation error: $e');
      return false;
    }
  }
}
