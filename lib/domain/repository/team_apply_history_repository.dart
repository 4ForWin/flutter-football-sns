import 'package:mercenaryhub/domain/entity/team_apply_history.dart';

abstract interface class TeamApplyHistoryRepository {
  /// 팀이 용병에게 신청한 내역 조회
  Future<List<TeamApplyHistory>> fetchTeamApplyHistories(String teamId);

  /// 신청 상태 업데이트 (승인/거절)
  Future<bool> updateApplyStatus({
    required String applyHistoryId,
    required String status,
  });

  /// 특정 신청 내역 상세 조회
  Future<TeamApplyHistory?> fetchTeamApplyHistoryById(String applyHistoryId);
}
