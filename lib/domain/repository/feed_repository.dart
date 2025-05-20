import 'package:mercenaryhub/domain/entity/feed.dart';

abstract interface class FeedRepository {
  Future<List<Feed>> fetchFeeds();
  Future<bool> insertFeed({
    required String title,
    required String content,
    required String imageUrl,
    required String teamName,
    required String location,
  });
}
