import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mercenaryhub/data/dto/feed_dto.dart';
import 'package:mercenaryhub/data/dto/feed_log_dto.dart';
import 'package:mercenaryhub/domain/entity/feed.dart';
import 'package:mercenaryhub/domain/entity/time_state.dart';
import 'package:swipable_stack/swipable_stack.dart';

abstract interface class FeedLogDataSource {
  /// 피드로그 다 가져오기
  Future<List<FeedLogDto>> fetchFeedLogs(String uid);

  /// 피드로그 등록하기
  Future<bool> insertFeedLog({
    required String uid,
    required String feedId,
    required bool isApplicant,
  });

  // Future<void> addUserToList(Feed feed, SwipeDirection direction);
}
