import 'package:mercenaryhub/data/dto/feed_log_dto.dart';

abstract interface class TeamFeedLogDataSource {
  /// 피드로그 다 가져오기
  Future<List<FeedLogDto>> fetchTeamFeedLogs(String uid);

  /// 피드로그 등록하기
  Future<bool> insertTeamFeedLog({
    required String uid,
    required String feedId,
    required bool isApplicant,
  });
}
