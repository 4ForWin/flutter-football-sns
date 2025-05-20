import 'package:mercenaryhub/domain/repository/feed_repository.dart';

class InsertFeedUsecase {
  final FeedRepository _feedRepository;

  InsertFeedUsecase(this._feedRepository);

  Future<bool> execute({
    required String title,
    required String content,
    required String imageUrl,
    required String teamName,
    required String location,
  }) async {
    return await _feedRepository.insertFeed(
      title: title,
      content: content,
      imageUrl: imageUrl,
      teamName: teamName,
      location: location,
    );
  }
}
