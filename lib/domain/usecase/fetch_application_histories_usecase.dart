// domain/usecase/fetch_mercenary_apply_histories_usecase.dart

import 'package:mercenaryhub/domain/entity/my_team_application_history.dart';
import 'package:mercenaryhub/domain/repository/my_team_application_history_repository.dart';

class FetchApplicationHistoriesUsecase {
  final MyTeamApplicationHistoryRepository _repository;

  FetchApplicationHistoriesUsecase(this._repository);

  Future<List<MyTeamApplicationHistory>> execute() async {
    print('🚗🚗🚗🚗');
    return await _repository.fetchApplicationHistories();
  }
}
