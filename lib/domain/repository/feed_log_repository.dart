import 'package:mercenaryhub/domain/entity/feed_log.dart';

abstract interface class FeedLogRepository {
  /// 피드 다 가져오기
  Future<List<FeedLog>> fetchFeedLogs(String uid);

  /// 피드 등록하기
  Future<bool> insertFeedLog({
    required String uid,
    required String feedId,
    required bool isApplicant,
  });
}
