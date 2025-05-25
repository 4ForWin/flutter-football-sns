import 'package:mercenaryhub/domain/repository/my_mercenary_invitation_history_repository.dart';

class InviteToMercenaryUsecase {
  final MyMercenaryInvitationHistoryRepository
      _myMercenaryInvitationHistoryRepository;

  InviteToMercenaryUsecase(this._myMercenaryInvitationHistoryRepository);

  Future<bool> execute(String feedId) async {
    try {
      await _myMercenaryInvitationHistoryRepository.inviteToMercenary(feedId);
      print('✅ InviteToMercenaryUsecase: 용병 초대 완료 - feedId: $feedId');
      return true;
    } catch (e) {
      print('❌ InviteToMercenaryUsecase error: $e');
      return false;
    }
  }
}
