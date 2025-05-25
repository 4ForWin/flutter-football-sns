import 'package:mercenaryhub/domain/repository/my_team_application_history_repository.dart';

class ApplyToTeamUsecase {
  final MyTeamApplicationHistoryRepository _myTeamApplicationHistoryRepository;

  ApplyToTeamUsecase(this._myTeamApplicationHistoryRepository);

  void execute(String feedId) {
    _myTeamApplicationHistoryRepository.applyToTeam(feedId);
  }
}
