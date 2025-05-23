import 'package:mercenaryhub/domain/entity/team_apply_history.dart';
import 'package:mercenaryhub/domain/repository/team_apply_history_repository.dart';

class FetchTeamApplyHistoriesUsecase {
  final TeamApplyHistoryRepository _repository;

  FetchTeamApplyHistoriesUsecase(this._repository);

  Future<List<TeamApplyHistory>> execute(String teamId) async {
    return await _repository.fetchTeamApplyHistories(teamId);
  }
}
