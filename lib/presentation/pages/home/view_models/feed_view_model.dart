import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercenaryhub/domain/entity/feed.dart';
import 'package:mercenaryhub/domain/entity/feed_log.dart';
import 'package:mercenaryhub/domain/usecase/stream_fetch_feeds_usecase.dart';
import 'package:mercenaryhub/presentation/pages/providers.dart';
import 'package:swipable_stack/swipable_stack.dart';

class FeedViewModel extends Notifier<List<Feed>> {
  @override
  build() {
    print('✅FeedViewModel build');
    // streamFetchFeeds();
    // fetchFeeds();
    initialize();
    return [];
  }

  String? _lastId;
  bool _isLast = false;
  List<FeedLog>? _feedLog;

  void initialize() async {
    // TODO: uid로 변경하기
    await fetchFeedLogs('hj');
    fetchFeeds();
  }

  void fetchFeeds() async {
    print('✅FeedViewModel fetchFeeds');
    if (_isLast) return;

    final fetchFeedsUsecase = ref.read(fetchFeedsUsecaseProvider);
    final feedIds = _feedLog?.map((e) => e.feedId).toList() ?? [];
    print('😍');
    print(feedIds);
    print('😍');
    final nextFeeds = await fetchFeedsUsecase.execute(_lastId, feedIds);

    print('❌❌❌');
    print(nextFeeds.length);
    print('❌❌❌');
    _isLast = nextFeeds.isEmpty;

    if (_isLast) return;
    _lastId = nextFeeds.last.id;
    state = [...state, ...nextFeeds];

    // state = await fetchFeedsUsecase.execute();
    // state = [...state, ...await fetchFeedsUsecase.execute()];
  }

  void streamFetchFeeds() {
    print('✅FeedViewModel streamFetchFeeds');
    final streamFetchFeedsUsecase = ref.read(streamFetchFeedsUsecaseProvider);
    final streamFeedList = streamFetchFeedsUsecase.execute();

    final streamSubscription = streamFeedList.listen((feeds) {
      state = feeds;
    });

    // 뷰모델이 메모리에서 소거될 때 onDispose의 callback이 호출 됨
    ref.onDispose(() {
      // ✅✅ 호출되면 streamSubscription을 cancel 꼭 해줘야함.
      // ✅✅ 그래야 구독이 종료된다.
      streamSubscription.cancel();
    });
  }

  Future<void> addUserToList(Feed feed, SwipeDirection direction) async {
    final addUserToListUsecase = ref.read(addUserToListUsecaseProvider);
    await addUserToListUsecase.execute(feed, direction);
  }

  Future<void> fetchFeedLogs(String uid) async {
    final fetchFeedLogsUsecase = ref.read(fetchFeedLogsUsecaseProvider);
    _feedLog = await fetchFeedLogsUsecase.execute(uid);
  }

  Future<void> insertFeedLog({
    required String uid,
    required String feedId,
    required bool isApplicant,
  }) async {
    final insertFeedLogUsecase = ref.read(insertFeedLogUsecaseProvider);
    await insertFeedLogUsecase.execute(uid, feedId, isApplicant);
  }
}

final feedViewModelProvider = NotifierProvider<FeedViewModel, List<Feed>>(
  () {
    return FeedViewModel();
  },
);
