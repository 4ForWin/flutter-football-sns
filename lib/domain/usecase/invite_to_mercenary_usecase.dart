import 'package:mercenaryhub/domain/repository/my_mercenary_invitation_history_repository.dart';
import 'package:mercenaryhub/domain/repository/my_team_application_history_repository.dart';

class InviteToMercenaryUsecase {
  final MyMercenaryInvitationHistoryRepository
      _myMercenaryInvitationHistoryRepository;

  InviteToMercenaryUsecase(this._myMercenaryInvitationHistoryRepository);

  void execute(String feedId) {
    _myMercenaryInvitationHistoryRepository.inviteToMercenary(feedId);
  }
}
