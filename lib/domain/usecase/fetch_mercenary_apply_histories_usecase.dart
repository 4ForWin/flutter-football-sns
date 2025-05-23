// domain/usecase/fetch_mercenary_apply_histories_usecase.dart

import 'package:mercenaryhub/domain/entity/mercenary_apply_history.dart';
import 'package:mercenaryhub/domain/repository/mercenary_apply_history_repository.dart';

class FetchMercenaryApplyHistoriesUsecase {
  final MercenaryApplyHistoryRepository _repository;

  FetchMercenaryApplyHistoriesUsecase(this._repository);

  Future<List<MercenaryApplyHistory>> execute(String userId) async {
    return await _repository.fetchMercenaryApplyHistories(userId);
  }
}
