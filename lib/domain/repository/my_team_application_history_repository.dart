import 'package:mercenaryhub/domain/entity/my_team_application_history.dart';

abstract interface class MyTeamApplicationHistoryRepository {
  /// 용병이 팀에 신청한 내역 조회
  Future<List<MyTeamApplicationHistory>> fetchApplicationHistories();

  // /// 신청 취소
  // Future<bool> cancelApply(String applyHistoryId);

  // /// 특정 신청 내역 상세 조회
  // Future<MercenaryApplyHistory?> fetchMercenaryApplyHistoryById(
  //     String applyHistoryId);

  /// 팀 합류 신청하기
  void applyToTeam(String feedId);
}
