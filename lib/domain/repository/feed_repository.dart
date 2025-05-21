import 'package:mercenaryhub/domain/entity/feed.dart';

abstract interface class FeedRepository {
  Future<List<Feed>> fetchFeeds();
  Future<bool> insertFeed({
    required String cost,
    required String person,
    required String imageUrl,
    required String teamName,
    required String location,
    required String level,
    required DateTime date,
  });
}
