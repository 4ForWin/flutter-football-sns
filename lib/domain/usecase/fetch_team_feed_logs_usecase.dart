import 'package:mercenaryhub/domain/entity/team_feed_log.dart';
import 'package:mercenaryhub/domain/repository/team_feed_log_repository.dart';

class FetchTeamFeedLogsUsecase {
  final TeamFeedLogRepository _teamFeedLogRepository;

  FetchTeamFeedLogsUsecase(this._teamFeedLogRepository);

  Future<List<TeamFeedLog>> execute(String uid) async {
    return await _teamFeedLogRepository.fetchTeamFeedLogs(uid);
  }
}
