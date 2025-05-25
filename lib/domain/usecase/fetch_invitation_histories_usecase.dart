// domain/usecase/fetch_mercenary_apply_histories_usecase.dart

import 'package:mercenaryhub/domain/entity/my_mercenary_invitation_history.dart';
import 'package:mercenaryhub/domain/entity/my_team_application_history.dart';
import 'package:mercenaryhub/domain/repository/my_mercenary_invitation_history_repository.dart';
import 'package:mercenaryhub/domain/repository/my_team_application_history_repository.dart';

class FetchInvitationHistoriesUsecase {
  final MyMercenaryInvitationHistoryRepository _repository;

  FetchInvitationHistoriesUsecase(this._repository);

  Future<List<MyMercenaryInvitationHistory>> execute() async {
    print('🚗🚗🚗🚗');
    return await _repository.fetchInvitationHistories();
  }
}
