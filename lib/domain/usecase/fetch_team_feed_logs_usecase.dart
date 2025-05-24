import 'package:mercenaryhub/domain/entity/feed_log.dart';
import 'package:mercenaryhub/domain/repository/team_feed_log_repository.dart';

class FetchTeamFeedLogsUsecase {
  final TeamFeedLogRepository _teamFeedLogRepository;

  FetchTeamFeedLogsUsecase(this._teamFeedLogRepository);

  Future<List<FeedLog>> execute(String uid) async {
    return await _teamFeedLogRepository.fetchTeamFeedLogs(uid);
  }
}
