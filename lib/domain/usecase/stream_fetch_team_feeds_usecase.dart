import 'package:mercenaryhub/domain/entity/feed.dart';
import 'package:mercenaryhub/domain/repository/team_feed_repository.dart';

class StreamFetchTeamFeedsUsecase {
  final TeamFeedRepository _teamFeedRepository;

  StreamFetchTeamFeedsUsecase(this._teamFeedRepository);

  Stream<List<Feed>> execute() {
    return _teamFeedRepository.streamFetchTeamFeeds();
  }
}
