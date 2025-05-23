import 'package:mercenaryhub/data/data_source/feed_data_source.dart';
import 'package:mercenaryhub/domain/entity/feed.dart';
import 'package:mercenaryhub/domain/entity/time_state.dart';
import 'package:mercenaryhub/domain/repository/feed_repository.dart';

class FeedRepositoryImpl implements FeedRepository {
  final FeedDataSource _feedDataSource;

  FeedRepositoryImpl(this._feedDataSource);

  @override
  Future<List<Feed>> fetchFeeds() async {
    final feedDtoList = await _feedDataSource.fetchFeeds();

    return feedDtoList.map((feedDto) {
      return Feed(
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
  Future<bool> insertFeed({
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
    bool isComplete = await _feedDataSource.insertFeed(
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
  Stream<List<Feed>> streamFetchFeeds() {
    final streamFeedDtoList = _feedDataSource.streamFetchFeeds();

    return streamFeedDtoList.map((feedDtoList) {
      return feedDtoList.map((feedDto) {
        return Feed(
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
