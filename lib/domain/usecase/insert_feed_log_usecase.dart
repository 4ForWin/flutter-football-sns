import 'package:mercenaryhub/domain/entity/feed_log.dart';
import 'package:mercenaryhub/domain/repository/feed_log_repository.dart';

class InsertFeedLogUsecase {
  final FeedLogRepository _feedLogRepository;

  InsertFeedLogUsecase(this._feedLogRepository);

  Future<bool> execute(
    String uid,
    String feedId,
    bool isApplicant,
  ) async {
    return await _feedLogRepository.insertFeedLog(
        uid: uid, feedId: feedId, isApplicant: isApplicant);
  }
}
