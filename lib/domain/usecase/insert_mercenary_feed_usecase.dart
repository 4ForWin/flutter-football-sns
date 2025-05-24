import 'package:mercenaryhub/domain/entity/time_state.dart';
import 'package:mercenaryhub/domain/repository/mercenary_feed_repository.dart';

class InsertMercenaryFeedUsecase {
  final MercenaryFeedRepository _mercenaryFeedRepository;

  InsertMercenaryFeedUsecase(this._mercenaryFeedRepository);

  Future<bool> execute({
    required String cost,
    required String imageUrl,
    required String name,
    required String location,
    required String level,
    required DateTime date,
    required TimeState time,
    required String content,
  }) async {
    return await _mercenaryFeedRepository.insertMercenaryFeed(
      cost: cost,
      imageUrl: imageUrl,
      name: name,
      location: location,
      level: level,
      date: date,
      time: time,
      content: content,
    );
  }
}
