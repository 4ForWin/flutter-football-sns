import 'package:mercenaryhub/domain/entity/feed.dart';
import 'package:mercenaryhub/domain/repository/feed_repository.dart';

class FetchFeedsUsecase {
  final FeedRepository _feedRepository;

  FetchFeedsUsecase(this._feedRepository);

  Future<List<Feed>> execute(
    String? lastId,
    List<String> ignoreIds,
  ) async {
    return await _feedRepository.fetchFeeds(lastId, ignoreIds);
  }
}
