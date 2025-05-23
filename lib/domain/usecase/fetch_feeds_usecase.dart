import 'package:mercenaryhub/domain/entity/feed.dart';
import 'package:mercenaryhub/domain/repository/feed_repository.dart';

class FetchFeedsUsecase {
  final FeedRepository _feedRepository;

  FetchFeedsUsecase(this._feedRepository);

  Future<List<Feed>> execute({
    required String? lastId,
    required List<String> ignoreIds,
    required String? location,
  }) async {
    return await _feedRepository.fetchFeeds(
      lastId: lastId,
      ignoreIds: ignoreIds,
      location: location,
    );
  }
}
