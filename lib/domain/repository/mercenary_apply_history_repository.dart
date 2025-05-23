import 'package:mercenaryhub/domain/entity/mercenary_apply_history.dart';

abstract interface class MercenaryApplyHistoryRepository {
  /// 용병이 팀에 신청한 내역 조회
  Future<List<MercenaryApplyHistory>> fetchMercenaryApplyHistories(
      String userId);

  /// 신청 취소
  Future<bool> cancelApply(String applyHistoryId);

  /// 특정 신청 내역 상세 조회
  Future<MercenaryApplyHistory?> fetchMercenaryApplyHistoryById(
      String applyHistoryId);
}
