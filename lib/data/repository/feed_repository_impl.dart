import 'package:mercenaryhub/data/data_source/feed_data_source.dart';
import 'package:mercenaryhub/domain/entity/feed.dart';
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
          title: feedDto.title,
          content: feedDto.content,
          imageUrl: feedDto.imageUrl,
          teamName: feedDto.teamName,
          location: feedDto.location);
    }).toList();
  }

  @override
  Future<bool> insertFeed({
    required String title,
    required String content,
    required String imageUrl,
    required String teamName,
    required String location,
  }) async {
    bool isComplete = await _feedDataSource.insertFeed(
        title: title,
        content: content,
        imageUrl: imageUrl,
        teamName: teamName,
        location: location);
    return isComplete;
  }
}
