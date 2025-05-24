import 'package:mercenaryhub/data/data_source/mercenary_feed_data_source.dart';
import 'package:mercenaryhub/domain/entity/mercenary_feed.dart';
import 'package:mercenaryhub/domain/entity/time_state.dart';
import 'package:mercenaryhub/domain/repository/mercenary_feed_repository.dart';

class MercenaryFeedRepositoryImpl implements MercenaryFeedRepository {
  final MercenaryFeedDataSource _mercenaryFeedDataSource;

  MercenaryFeedRepositoryImpl(this._mercenaryFeedDataSource);

  @override
  Future<List<MercenaryFeed>> fetchMercenaryFeeds({
    required String? lastId,
    required List<String> ignoreIds,
    required String? location,
  }) async {
    final feedDtoList = await _mercenaryFeedDataSource.fetchMercenaryFeeds(
      lastId: lastId,
      ignoreIds: ignoreIds,
      location: location,
    );

    return feedDtoList.map((feedDto) {
      return MercenaryFeed(
        id: feedDto.id,
        cost: feedDto.cost,
        imageUrl: feedDto.imageUrl,
        name: feedDto.name,
        location: feedDto.location,
        level: feedDto.level,
        date: DateTime.parse(feedDto.date),
        time: feedDto.time,
        content: feedDto.content,
      );
    }).toList();
  }

  @override
  Future<bool> insertMercenaryFeed({
    required String cost,
    required String imageUrl,
    required String name,
    required String location,
    required String level,
    required DateTime date,
    required TimeState time,
    required String content,
  }) async {
    bool isComplete = await _mercenaryFeedDataSource.insertMercenaryFeed(
      cost: cost,
      imageUrl: imageUrl,
      name: name,
      location: location,
      level: level,
      date: date,
      time: time,
      content: content,
    );
    return isComplete;
  }

  @override
  Stream<List<MercenaryFeed>> streamFetchMercenaryFeeds() {
    final streamFeedDtoList =
        _mercenaryFeedDataSource.streamFetchMercenaryFeeds();

    return streamFeedDtoList.map((feedDtoList) {
      return feedDtoList.map((feedDto) {
        return MercenaryFeed(
          id: feedDto.id,
          cost: feedDto.cost,
          imageUrl: feedDto.imageUrl,
          name: feedDto.name,
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
