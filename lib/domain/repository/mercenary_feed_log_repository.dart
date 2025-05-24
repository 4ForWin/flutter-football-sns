import 'package:mercenaryhub/domain/entity/mercenary_feed_log.dart';

abstract interface class MercenaryFeedLogRepository {
  /// 피드 다 가져오기
  Future<List<MercenaryFeedLog>> fetchMercenaryFeedLogs(String uid);

  /// 피드 등록하기
  Future<bool> insertMercenaryFeedLog({
    required String uid,
    required String feedId,
    required bool isApplicant,
  });
}
