import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mercenaryhub/domain/entity/feed.dart';
import 'package:mercenaryhub/domain/entity/time_state.dart';
import 'package:swipable_stack/swipable_stack.dart';

abstract interface class FeedRepository {
  Future<List<Feed>> fetchFeeds(
    String? lastId,
    List<String> ignoreIds,
  );
  Future<bool> insertFeed({
    required String cost,
    required String person,
    required String imageUrl,
    required String teamName,
    required String location,
    required String level,
    required DateTime date,
    required TimeState time,
    required String content,
  });
  Stream<List<Feed>> streamFetchFeeds();
  Future<void> addUserToList(Feed feed, SwipeDirection direction);
}
