import 'package:mercenaryhub/domain/entity/feed.dart';
import 'package:mercenaryhub/domain/repository/feed_repository.dart';
import 'package:swipable_stack/swipable_stack.dart';

class AddUserToListUsecase {
  FeedRepository _feedRepository;

  AddUserToListUsecase(this._feedRepository);

  Future<void> execute(Feed feed, SwipeDirection direction) async {
    await _feedRepository.addUserToList(feed, direction);
  }
}
