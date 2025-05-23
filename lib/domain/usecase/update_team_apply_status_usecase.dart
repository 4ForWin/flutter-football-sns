import 'package:mercenaryhub/domain/repository/team_apply_history_repository.dart';

class UpdateTeamApplyStatusUsecase {
  final TeamApplyHistoryRepository _repository;

  UpdateTeamApplyStatusUsecase(this._repository);

  Future<bool> execute({
    required String applyHistoryId,
    required String status,
  }) async {
    return await _repository.updateApplyStatus(
      applyHistoryId: applyHistoryId,
      status: status,
    );
  }
}
