import 'package:mercenaryhub/data/data_source/feed_log_data_source.dart';
import 'package:mercenaryhub/domain/entity/feed_log.dart';
import 'package:mercenaryhub/domain/repository/feed_log_repository.dart';

class FeedLogRepositoryImpl implements FeedLogRepository {
  final FeedLogDataSource _feedLogDataSource;

  FeedLogRepositoryImpl(this._feedLogDataSource);

  @override
  Future<List<FeedLog>> fetchFeedLogs(String uid) async {
    final feedLogDtoList = await _feedLogDataSource.fetchFeedLogs(uid);

    return feedLogDtoList.map((feedLogDto) {
      return FeedLog(
        feedId: feedLogDto.feedId,
        isApplicant: feedLogDto.isApplicant,
        uid: feedLogDto.uid,
      );
    }).toList();
  }

  @override
  Future<bool> insertFeedLog({
    required String uid,
    required String feedId,
    required bool isApplicant,
  }) async {
    return await _feedLogDataSource.insertFeedLog(
      uid: uid,
      feedId: feedId,
      isApplicant: isApplicant,
    );
  }
}
