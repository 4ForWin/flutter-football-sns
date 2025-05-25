import 'package:mercenaryhub/domain/entity/team_feed.dart';
import 'package:mercenaryhub/domain/repository/team_feed_repository.dart';

class FetchTeamFeedsUsecase {
  final TeamFeedRepository _teamFeedRepository;

  FetchTeamFeedsUsecase(this._teamFeedRepository);

  Future<List<TeamFeed>> execute({
    required String? lastId,
    required List<String> ignoreIds,
    required String? location,
  }) async {
    return await _teamFeedRepository.fetchTeamFeeds(
      lastId: lastId,
      ignoreIds: ignoreIds,
      location: location,
    );
  }
}
