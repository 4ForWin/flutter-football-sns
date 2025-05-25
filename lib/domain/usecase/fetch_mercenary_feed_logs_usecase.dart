import 'package:mercenaryhub/domain/entity/mercenary_feed_log.dart';
import 'package:mercenaryhub/domain/repository/mercenary_feed_log_repository.dart';

class FetchMercenaryFeedLogsUsecase {
  final MercenaryFeedLogRepository _mercenaryFeedLogRepository;

  FetchMercenaryFeedLogsUsecase(this._mercenaryFeedLogRepository);

  Future<List<MercenaryFeedLog>> execute(String uid) async {
    return await _mercenaryFeedLogRepository.fetchMercenaryFeedLogs(uid);
  }
}
