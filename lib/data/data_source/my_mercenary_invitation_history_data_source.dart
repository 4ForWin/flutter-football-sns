import 'package:mercenaryhub/data/dto/my_mercenary_invitation_history_dto.dart';

abstract interface class MyMercenaryInvitationHistoryDataSource {
  /// 팀이 용병을 초대한 내역 조회
  Future<List<MyMercenaryInvitationHistoryDto>> fetchInvitationHistories();

  /// 용병 초대하기 - 수정: Future<bool> 반환하도록 변경
  Future<bool> inviteToMercenary(String feedId);
}
