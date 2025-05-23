import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mercenaryhub/data/dto/feed_dto.dart';
import 'package:mercenaryhub/data/dto/feed_log_dto.dart';
import 'package:mercenaryhub/domain/entity/feed.dart';
import 'package:mercenaryhub/domain/entity/feed_log.dart';
import 'package:mercenaryhub/domain/entity/time_state.dart';
import 'package:swipable_stack/swipable_stack.dart';

abstract interface class FeedLogRepository {
  /// 피드 다 가져오기
  Future<List<FeedLog>> fetchFeedLogs(String uid);

  /// 피드 등록하기
  Future<bool> insertFeedLog({
    required String uid,
    required String feedId,
    required bool isApplicant,
  });
}
