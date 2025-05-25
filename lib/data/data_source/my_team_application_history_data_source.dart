import 'package:mercenaryhub/data/dto/my_team_application_history_dto.dart';
import 'package:mercenaryhub/data/dto/team_feed_dto.dart';

abstract interface class MyTeamApplicationHistoryDataSource {
  /// 용병이 팀에 신청한 내역 조회
  // Future<List<MercenaryApplyHistoryDto>> fetchMercenaryApplyHistories();
  Future<List<MyTeamApplicationHistoryDto>> fetchApplicationHistories();

  /// 신청 취소
  // Future<bool> cancelApply(String applyHistoryId);

  // /// 특정 신청 내역 조회
  // Future<MyTeamApplicationHistoryDto?> fetchMercenaryApplyHistoryById(
  //     String applyHistoryId);

  /// 팀 합류 신청하기
  void applyToTeam(String feedId);
}
