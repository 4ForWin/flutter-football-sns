import 'package:mercenaryhub/domain/entity/team_feed_log.dart';

abstract interface class TeamFeedLogRepository {
  /// 피드 다 가져오기
  Future<List<TeamFeedLog>> fetchTeamFeedLogs(String uid);

  /// 피드 등록하기
  Future<bool> insertTeamFeedLog({
    required String uid,
    required String feedId,
    required bool isApplicant,
  });
}
