import 'package:mercenaryhub/data/dto/mercenary_apply_history_dto.dart';

abstract interface class MercenaryApplyHistoryDataSource {
  /// 용병이 팀에 신청한 내역 조회
  Future<List<MercenaryApplyHistoryDto>> fetchMercenaryApplyHistories(
      String userId);

  /// 신청 취소
  Future<bool> cancelApply(String applyHistoryId);

  /// 특정 신청 내역 조회
  Future<MercenaryApplyHistoryDto?> fetchMercenaryApplyHistoryById(
      String applyHistoryId);
}
