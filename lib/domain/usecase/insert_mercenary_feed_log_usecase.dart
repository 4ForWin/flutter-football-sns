import 'package:mercenaryhub/domain/repository/mercenary_feed_log_repository.dart';

class InsertMercenaryFeedLogUsecase {
  final MercenaryFeedLogRepository _mercenaryFeedLogRepository;

  InsertMercenaryFeedLogUsecase(this._mercenaryFeedLogRepository);

  Future<bool> execute(
    String uid,
    String feedId,
    bool isApplicant,
  ) async {
    return await _mercenaryFeedLogRepository.insertMercenaryFeedLog(
      uid: uid,
      feedId: feedId,
      isApplicant: isApplicant,
    );
  }
}
