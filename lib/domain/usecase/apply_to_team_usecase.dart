import 'package:mercenaryhub/domain/repository/my_team_application_history_repository.dart';

class ApplyToTeamUsecase {
  final MyTeamApplicationHistoryRepository _myTeamApplicationHistoryRepository;

  ApplyToTeamUsecase(this._myTeamApplicationHistoryRepository);

  Future<bool> execute(String feedId) async {
    try {
      await _myTeamApplicationHistoryRepository.applyToTeam(feedId);
      print('✅ ApplyToTeamUsecase: 팀 신청 완료 - feedId: $feedId');
      return true;
    } catch (e) {
      print('❌ ApplyToTeamUsecase error: $e');
      return false;
    }
  }
}
