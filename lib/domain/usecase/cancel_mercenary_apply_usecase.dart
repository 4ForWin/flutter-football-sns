// domain/usecase/cancel_mercenary_apply_usecase.dart

import 'package:mercenaryhub/domain/repository/mercenary_apply_history_repository.dart';

class CancelMercenaryApplyUsecase {
  final MercenaryApplyHistoryRepository _repository;

  CancelMercenaryApplyUsecase(this._repository);

  Future<bool> execute(String applyHistoryId) async {
    return await _repository.cancelApply(applyHistoryId);
  }
}
