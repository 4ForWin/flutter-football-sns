import 'package:mercenaryhub/data/repository/team_invitation_received_repository.dart';

class RespondToTeamInvitationUsecase {
  final TeamInvitationReceivedRepository _repository;

  RespondToTeamInvitationUsecase(this._repository);

  Future<bool> execute({
    required String feedId,
    required String response,
  }) async {
    try {
      print(
          '🚗 UseCase: respondToTeamInvitation 실행 - feedId: $feedId, response: $response');
      return await _repository.respondToTeamInvitation(
        feedId: feedId,
        response: response,
      );
    } catch (e) {
      print('❌ RespondToTeamInvitationUsecase error: $e');
      return false;
    }
  }
}
