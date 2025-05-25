import 'package:mercenaryhub/domain/entity/my_mercenary_invitation_history.dart';

abstract interface class MyMercenaryInvitationHistoryRepository {
  /// 팀이 용병을 초대한 내역 조회
  Future<List<MyMercenaryInvitationHistory>> fetchInvitationHistories();

  /// 용병 초대하기 - 수정: Future<bool> 반환하도록 변경
  Future<bool> inviteToMercenary(String feedId);

  /// 초대 취소 - 추후 구현 예정
  // Future<bool> cancelInvitation(String invitationId);
}
