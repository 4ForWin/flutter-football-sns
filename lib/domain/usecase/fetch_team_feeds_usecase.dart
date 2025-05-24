import 'package:mercenaryhub/domain/entity/feed.dart';
import 'package:mercenaryhub/domain/repository/team_feed_repository.dart';

class FetchTeamFeedsUsecase {
  final TeamFeedRepository _feedRepository;

  FetchTeamFeedsUsecase(this._feedRepository);

  Future<List<Feed>> execute({
    required String? lastId,
    required List<String> ignoreIds,
    required String? location,
  }) async {
    return await _feedRepository.fetchTeamFeeds(
      lastId: lastId,
      ignoreIds: ignoreIds,
      location: location,
    );
  }
}
