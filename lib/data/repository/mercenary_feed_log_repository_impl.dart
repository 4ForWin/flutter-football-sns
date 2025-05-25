import 'package:mercenaryhub/data/data_source/mercenary_feed_log_data_source.dart';
import 'package:mercenaryhub/domain/entity/mercenary_feed_log.dart';
import 'package:mercenaryhub/domain/repository/mercenary_feed_log_repository.dart';

class MercenaryFeedLogRepositoryImpl implements MercenaryFeedLogRepository {
  final MercenaryFeedLogDataSource _mercenaryFeedLogDataSource;

  MercenaryFeedLogRepositoryImpl(this._mercenaryFeedLogDataSource);

  @override
  Future<List<MercenaryFeedLog>> fetchMercenaryFeedLogs(String uid) async {
    final feedLogDtoList =
        await _mercenaryFeedLogDataSource.fetchMercenaryFeedLogs(uid);

    return feedLogDtoList.map((feedLogDto) {
      return MercenaryFeedLog(
        feedId: feedLogDto.feedId,
        isApplicant: feedLogDto.isApplicant,
        uid: feedLogDto.uid,
      );
    }).toList();
  }

  @override
  Future<bool> insertMercenaryFeedLog({
    required String uid,
    required String feedId,
    required bool isApplicant,
  }) async {
    return await _mercenaryFeedLogDataSource.insertMercenaryFeedLog(
      uid: uid,
      feedId: feedId,
      isApplicant: isApplicant,
    );
  }
}
