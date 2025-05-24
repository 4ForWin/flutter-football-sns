import 'package:mercenaryhub/domain/repository/team_feed_log_repository.dart';

class InsertTeamFeedLogUsecase {
  final TeamFeedLogRepository _teamFeedLogRepository;

  InsertTeamFeedLogUsecase(this._teamFeedLogRepository);

  Future<bool> execute(
    String uid,
    String feedId,
    bool isApplicant,
  ) async {
    return await _teamFeedLogRepository.insertTeamFeedLog(
        uid: uid, feedId: feedId, isApplicant: isApplicant);
  }
}
