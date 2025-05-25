import 'package:mercenaryhub/data/dto/mercenary_feed_dto.dart';
import 'package:mercenaryhub/domain/entity/time_state.dart';

abstract interface class MercenaryFeedDataSource {
  /// 피드 다 가져오기
  Future<List<MercenaryFeedDto>> fetchMercenaryFeeds({
    required String? lastId,
    required List<String> ignoreIds,
    required String? location,
  });

  /// 피드 등록하기
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

  /// 피드 스트림으로 다 가져오기
  Stream<List<MercenaryFeedDto>> streamFetchMercenaryFeeds();
}
