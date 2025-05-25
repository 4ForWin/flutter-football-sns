import 'package:mercenaryhub/data/data_source/team_feed_data_source.dart';
import 'package:mercenaryhub/domain/entity/team_feed.dart';
import 'package:mercenaryhub/domain/entity/time_state.dart';
import 'package:mercenaryhub/domain/repository/team_feed_repository.dart';

class TeamFeedRepositoryImpl implements TeamFeedRepository {
  final TeamFeedDataSource _teamFeedDataSource;

  TeamFeedRepositoryImpl(this._teamFeedDataSource);

  @override
  Future<List<TeamFeed>> fetchTeamFeeds({
    required String? lastId,
    required List<String> ignoreIds,
    required String? location,
  }) async {
    final feedDtoList = await _teamFeedDataSource.fetchTeamFeeds(
      lastId: lastId,
      ignoreIds: ignoreIds,
      location: location,
    );

    return feedDtoList.map((feedDto) {
      return TeamFeed(
        id: feedDto.id,
        cost: feedDto.cost,
        person: feedDto.person,
        imageUrl: feedDto.imageUrl,
        teamName: feedDto.teamName,
        location: feedDto.location,
        level: feedDto.level,
        date: DateTime.parse(feedDto.date),
        time: feedDto.time,
        content: feedDto.content,
      );
    }).toList();
  }

  @override
  Future<bool> insertTeamFeed({
    required String cost,
    required String person,
    required String imageUrl,
    required String teamName,
    required String location,
    required String level,
    required DateTime date,
    required TimeState time,
    required String content,
  }) async {
    bool isComplete = await _teamFeedDataSource.insertTeamFeed(
      cost: cost,
      person: person,
      imageUrl: imageUrl,
      teamName: teamName,
      location: location,
      level: level,
      date: date,
      time: time,
      content: content,
    );
    return isComplete;
  }

  @override
  Stream<List<TeamFeed>> streamFetchTeamFeeds() {
    final streamFeedDtoList = _teamFeedDataSource.streamFetchTeamFeeds();

    return streamFeedDtoList.map((feedDtoList) {
      return feedDtoList.map((feedDto) {
        return TeamFeed(
          id: feedDto.id,
          cost: feedDto.cost,
          person: feedDto.person,
          imageUrl: feedDto.imageUrl,
          teamName: feedDto.teamName,
          location: feedDto.location,
          level: feedDto.level,
          date: DateTime.parse(feedDto.date),
          time: feedDto.time,
          content: feedDto.content,
        );
      }).toList();
    });
  }
}
