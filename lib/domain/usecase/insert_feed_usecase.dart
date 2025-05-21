import 'package:mercenaryhub/domain/repository/feed_repository.dart';

class InsertFeedUsecase {
  final FeedRepository _feedRepository;

  InsertFeedUsecase(this._feedRepository);

  Future<bool> execute({
    required String cost,
    required String person,
    required String imageUrl,
    required String teamName,
    required String location,
    required String level,
    required DateTime date,
  }) async {
    return await _feedRepository.insertFeed(
      cost: cost,
      person: person,
      imageUrl: imageUrl,
      teamName: teamName,
      location: location,
      level: level,
      date: date,
    );
  }
}
