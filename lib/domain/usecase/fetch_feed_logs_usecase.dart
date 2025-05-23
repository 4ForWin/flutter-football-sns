import 'package:mercenaryhub/domain/entity/feed_log.dart';
import 'package:mercenaryhub/domain/repository/feed_log_repository.dart';

class FetchFeedLogsUsecase {
  final FeedLogRepository _feedLogRepository;

  FetchFeedLogsUsecase(this._feedLogRepository);

  Future<List<FeedLog>> execute(String uid) async {
    return await _feedLogRepository.fetchFeedLogs(uid);
  }
}
