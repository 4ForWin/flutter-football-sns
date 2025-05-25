import 'package:mercenaryhub/domain/entity/team_feed.dart';
import 'package:mercenaryhub/domain/repository/team_feed_repository.dart';

class StreamFetchTeamFeedsUsecase {
  final TeamFeedRepository _teamFeedRepository;

  StreamFetchTeamFeedsUsecase(this._teamFeedRepository);

  Stream<List<TeamFeed>> execute() {
    return _teamFeedRepository.streamFetchTeamFeeds();
  }
}
