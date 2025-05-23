import 'package:mercenaryhub/data/dto/team_apply_history_dto.dart';

abstract interface class TeamApplyHistoryDataSource {
  /// 팀이 용병에게 신청한 내역 조회
  Future<List<TeamApplyHistoryDto>> fetchTeamApplyHistories(String teamId);

  /// 신청 상태 업데이트
  Future<bool> updateApplyStatus({
    required String applyHistoryId,
    required String status,
  });

  /// 특정 신청 내역 조회
  Future<TeamApplyHistoryDto?> fetchTeamApplyHistoryById(String applyHistoryId);
}
