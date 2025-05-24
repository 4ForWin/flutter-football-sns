import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercenaryhub/domain/entity/feed.dart';
import 'package:mercenaryhub/domain/entity/feed_log.dart';
import 'package:mercenaryhub/presentation/pages/providers.dart';
import 'package:mercenaryhub/presentation/pages/write.dart/write_view_model.dart';
import 'package:swipable_stack/swipable_stack.dart';

class TeamFeedViewModel extends Notifier<List<Feed>> {
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
  String? _location;

  void setLocationAndRefresh(String? location) {
    _location = location;
    _isLast = false;
    _lastId = null;

    state = [];
    fetchTeamFeeds();
  }

  void initialize() async {
    // TODO: uid로 변경하기
    await fetchTeamFeedLogs(FirebaseAuth.instance.currentUser!.uid);
    fetchTeamFeeds();
  }

  void fetchTeamFeeds() async {
    print('✅FeedViewModel fetchFeeds');
    if (_isLast) return;

    final fetchTeamFeedsUsecase = ref.read(fetchTeamFeedsUsecaseProvider);
    final feedIds = _feedLog?.map((e) => e.feedId).toList() ?? [];
    print('😍');
    print('feedIds : $feedIds');
    print('😍');
    // final nextFeeds = await fetchFeedsUsecase.execute(_lastId, feedIds);
    final nextFeeds = await fetchTeamFeedsUsecase.execute(
      lastId: _lastId,
      ignoreIds: feedIds,
      location: _location,
    );

    print('👿');
    print(nextFeeds.length);
    print('👿');
    _isLast = nextFeeds.isEmpty;

    if (_isLast) return;
    _lastId = nextFeeds.last.id;
    state = [...state, ...nextFeeds];

    // state = await fetchFeedsUsecase.execute();
    // state = [...state, ...await fetchFeedsUsecase.execute()];
  }

  void streamFetchTeamFeeds() {
    print('✅FeedViewModel streamFetchFeeds');
    final streamFetchTeamFeedsUsecase =
        ref.read(streamFetchTeamFeedsUsecaseProvider);
    final streamFeedList = streamFetchTeamFeedsUsecase.execute();

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

  Future<void> fetchTeamFeedLogs(String uid) async {
    final fetchTeamFeedLogsUsecase = ref.read(fetchTeamFeedLogsUsecaseProvider);
    _feedLog = await fetchTeamFeedLogsUsecase.execute(uid);
  }

  Future<void> insertTeamFeedLog({
    required String uid,
    required String feedId,
    required bool isApplicant,
  }) async {
    final insertTeamFeedLogUsecase = ref.read(insertTeamFeedLogUsecaseProvider);
    await insertTeamFeedLogUsecase.execute(uid, feedId, isApplicant);
  }
}

final feedViewModelProvider = NotifierProvider<TeamFeedViewModel, List<Feed>>(
  () {
    return TeamFeedViewModel();
  },
);
