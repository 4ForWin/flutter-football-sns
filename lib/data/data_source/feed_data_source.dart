import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mercenaryhub/data/dto/feed_dto.dart';
import 'package:mercenaryhub/domain/entity/feed.dart';
import 'package:mercenaryhub/domain/entity/time_state.dart';
import 'package:swipable_stack/swipable_stack.dart';

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

  /// 피드에 싫어요 리스트, 신청하기 리스트에 사용자 추가하기
  Future<void> addUserToList(Feed feed, SwipeDirection direction);
}
