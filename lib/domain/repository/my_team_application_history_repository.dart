import 'package:mercenaryhub/domain/entity/my_team_application_history.dart';

abstract interface class MyTeamApplicationHistoryRepository {
  /// 용병이 팀에 신청한 내역 조회
  Future<List<MyTeamApplicationHistory>> fetchApplicationHistories();

  /// 팀 합류 신청하기 - 수정: Future<bool> 반환하도록 변경
  Future<bool> applyToTeam(String feedId);

  /// 신청 취소 - 추후 구현 예정
  // Future<bool> cancelApply(String applyHistoryId);
}
