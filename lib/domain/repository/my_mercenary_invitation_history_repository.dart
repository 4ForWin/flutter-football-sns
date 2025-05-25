import 'package:mercenaryhub/domain/entity/my_mercenary_invitation_history.dart';
import 'package:mercenaryhub/domain/entity/my_team_application_history.dart';

abstract interface class MyMercenaryInvitationHistoryRepository {
  /// 팀이 용병을 초대한 내역
  Future<List<MyMercenaryInvitationHistory>> fetchInvitationHistories();

  // /// 신청 취소
  // Future<bool> cancelApply(String applyHistoryId);

  // /// 특정 신청 내역 상세 조회
  // Future<MercenaryApplyHistory?> fetchMercenaryApplyHistoryById(
  //     String applyHistoryId);

  /// 용병 초대하기
  void inviteToMercenary(String feedId);
}
