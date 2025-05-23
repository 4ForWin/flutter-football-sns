import 'package:mercenaryhub/data/dto/feed_dto.dart';
import 'package:mercenaryhub/domain/entity/time_state.dart';

abstract interface class FeedDataSource {
  /// 피드 다 가져오기
  Future<List<FeedDto>> fetchFeeds(String? lastId, List<String> ignoreIds);

  /// 피드 등록하기
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

  /// 피드 스트림으로 다 가져오기
  Stream<List<FeedDto>> streamFetchFeeds();
}
