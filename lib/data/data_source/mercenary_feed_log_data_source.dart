import 'package:mercenaryhub/data/dto/mercenary_feed_log_dto.dart';

abstract interface class MercenaryFeedLogDataSource {
  /// 피드로그 다 가져오기
  Future<List<MercenaryFeedLogDto>> fetchMercenaryFeedLogs(String uid);

  /// 피드로그 등록하기
  Future<bool> insertMercenaryFeedLog({
    required String uid,
    required String feedId,
    required bool isApplicant,
  });
}
