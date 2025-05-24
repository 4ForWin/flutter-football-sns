import 'package:mercenaryhub/data/data_source/team_feed_log_data_source.dart';
import 'package:mercenaryhub/domain/entity/feed_log.dart';
import 'package:mercenaryhub/domain/repository/team_feed_log_repository.dart';

class TeamFeedLogRepositoryImpl implements TeamFeedLogRepository {
  final TeamFeedLogDataSource _teamFeedLogDataSource;

  TeamFeedLogRepositoryImpl(this._teamFeedLogDataSource);

  @override
  Future<List<FeedLog>> fetchTeamFeedLogs(String uid) async {
    final feedLogDtoList = await _teamFeedLogDataSource.fetchTeamFeedLogs(uid);

    return feedLogDtoList.map((feedLogDto) {
      return FeedLog(
        feedId: feedLogDto.feedId,
        isApplicant: feedLogDto.isApplicant,
        uid: feedLogDto.uid,
      );
    }).toList();
  }

  @override
  Future<bool> insertTeamFeedLog({
    required String uid,
    required String feedId,
    required bool isApplicant,
  }) async {
    return await _teamFeedLogDataSource.insertTeamFeedLog(
      uid: uid,
      feedId: feedId,
      isApplicant: isApplicant,
    );
  }
}
