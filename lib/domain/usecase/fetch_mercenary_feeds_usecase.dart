import 'package:mercenaryhub/domain/entity/mercenary_feed.dart';
import 'package:mercenaryhub/domain/repository/mercenary_feed_repository.dart';

class FetchMercenaryFeedsUsecase {
  final MercenaryFeedRepository _mercenaryFeedRepository;

  FetchMercenaryFeedsUsecase(this._mercenaryFeedRepository);

  Future<List<MercenaryFeed>> execute({
    required String? lastId,
    required List<String> ignoreIds,
    required String? location,
  }) async {
    return await _mercenaryFeedRepository.fetchMercenaryFeeds(
      lastId: lastId,
      ignoreIds: ignoreIds,
      location: location,
    );
  }
}
