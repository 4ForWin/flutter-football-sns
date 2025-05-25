import 'package:mercenaryhub/data/dto/my_team_application_history_dto.dart';

abstract interface class MyTeamApplicationHistoryDataSource {
  /// 용병이 팀에 신청한 내역 조회
  Future<List<MyTeamApplicationHistoryDto>> fetchApplicationHistories();

  /// 팀 합류 신청하기 - 수정: Future<bool> 반환하도록 변경
  Future<bool> applyToTeam(String feedId);
}
