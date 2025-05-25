import 'package:mercenaryhub/data/dto/my_mercenary_invitation_history_dto.dart';
import 'package:mercenaryhub/data/dto/my_team_application_history_dto.dart';
import 'package:mercenaryhub/data/dto/team_feed_dto.dart';

abstract interface class MyMercenaryInvitationHistoryDataSource {
  /// 팀이 용병을 초대한 내역 조회
  Future<List<MyMercenaryInvitationHistoryDto>> fetchInvitationHistories();

  /// 신청 취소
  // Future<bool> cancelApply(String applyHistoryId);

  // /// 특정 신청 내역 조회
  // Future<MyTeamApplicationHistoryDto?> fetchMercenaryApplyHistoryById(
  //     String applyHistoryId);

  /// 용병 초대하기
  void inviteToMercenary(String feedId);
}
