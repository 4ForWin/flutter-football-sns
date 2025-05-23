import 'package:mercenaryhub/data/dto/feed_log_dto.dart';

abstract interface class FeedLogDataSource {
  /// 피드로그 다 가져오기
  Future<List<FeedLogDto>> fetchFeedLogs(String uid);

  /// 피드로그 등록하기
  Future<bool> insertFeedLog({
    required String uid,
    required String feedId,
    required bool isApplicant,
  });
}
