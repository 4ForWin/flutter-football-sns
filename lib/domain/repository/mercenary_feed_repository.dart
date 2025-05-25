import 'package:mercenaryhub/domain/entity/mercenary_feed.dart';
import 'package:mercenaryhub/domain/entity/time_state.dart';

abstract interface class MercenaryFeedRepository {
  Future<List<MercenaryFeed>> fetchMercenaryFeeds({
    required String? lastId,
    required List<String> ignoreIds,
    required String? location,
  });
  Future<bool> insertMercenaryFeed({
    required String cost,
    required String imageUrl,
    required String name,
    required String location,
    required String level,
    required DateTime date,
    required TimeState time,
    required String content,
  });
  Stream<List<MercenaryFeed>> streamFetchMercenaryFeeds();
}
