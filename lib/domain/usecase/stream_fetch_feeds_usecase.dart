import 'package:mercenaryhub/domain/entity/feed.dart';
import 'package:mercenaryhub/domain/repository/feed_repository.dart';

class StreamFetchFeedsUsecase {
  final FeedRepository _feedRepository;

  StreamFetchFeedsUsecase(this._feedRepository);

  Stream<List<Feed>> execute() {
    return _feedRepository.streamFetchFeeds();
  }
}
