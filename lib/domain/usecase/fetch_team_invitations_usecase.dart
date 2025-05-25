import 'package:mercenaryhub/data/repository/team_invitation_received_repository.dart';
import 'package:mercenaryhub/domain/entity/team_invitation_received.dart';

class FetchTeamInvitationsUsecase {
  final TeamInvitationReceivedRepository _repository;

  FetchTeamInvitationsUsecase(this._repository);

  Future<List<TeamInvitationReceived>> execute() async {
    try {
      print('🚗 UseCase: fetchTeamInvitations 실행');
      return await _repository.fetchTeamInvitations();
    } catch (e) {
      print('❌ FetchTeamInvitationsUsecase error: $e');
      return [];
    }
  }
}
