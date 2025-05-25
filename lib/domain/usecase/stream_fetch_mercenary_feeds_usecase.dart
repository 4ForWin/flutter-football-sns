import 'package:mercenaryhub/domain/entity/mercenary_feed.dart';
import 'package:mercenaryhub/domain/repository/mercenary_feed_repository.dart';

class StreamFetchMercenaryFeedsUsecase {
  final MercenaryFeedRepository _mercenaryFeedRepository;

  StreamFetchMercenaryFeedsUsecase(this._mercenaryFeedRepository);

  Stream<List<MercenaryFeed>> execute() {
    return _mercenaryFeedRepository.streamFetchMercenaryFeeds();
  }
}
