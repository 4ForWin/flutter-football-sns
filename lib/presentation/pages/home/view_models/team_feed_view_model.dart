import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercenaryhub/data/data_source/my_team_application_history_data_source_impl.dart';
import 'package:mercenaryhub/domain/entity/team_feed.dart';
import 'package:mercenaryhub/domain/entity/team_feed_log.dart';
import 'package:mercenaryhub/domain/usecase/apply_to_team_usecase.dart';
import 'package:mercenaryhub/presentation/pages/providers.dart';

class TeamFeedViewModel extends Notifier<List<TeamFeed>> {
  @override
  build() {
    print('✅TeamFeedViewModel build');
    // streamFetchFeeds();
    // fetchFeeds();
    initialize();
    return [];
  }

  String? _lastId;
  bool _isLast = false;
  List<TeamFeedLog>? _feedLog;
  String? _location;

  void setLocationAndRefresh(String? location) {
    _location = location;
    _isLast = false;
    _lastId = null;

    state = [];
    fetchTeamFeeds();
  }

  void initialize() async {
    await fetchTeamFeedLogs(FirebaseAuth.instance.currentUser!.uid);
    fetchTeamFeeds();
  }

  void fetchTeamFeeds() async {
    print('✅FeedViewModel fetchFeeds');
    if (_isLast) return;

    print('👰‍♂️👰‍♂️👰‍♂️');
    print(_feedLog);
    print('👰‍♂️👰‍♂️👰‍♂️');
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
    print('team❌❌❌❌❌❌❌❌');
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

    _feedLog = [
      ..._feedLog ?? [],
      TeamFeedLog(
        uid: uid,
        feedId: feedId,
        isApplicant: isApplicant,
      ),
    ];

    await insertTeamFeedLogUsecase.execute(uid, feedId, isApplicant);

    // 신청으로 스와이프 했으면 'users/userId/teamApplicationHistory'으로 데이터 보내기
    if (isApplicant) {
      final applyToTeamUsecase = ref.read(applyToTeamUsecaseProvider);

      applyToTeamUsecase.execute(feedId);
    }
  }

  void removeFeedOfState() {
    state.removeAt(0);
    state = [...state];
  }
}

final teamFeedViewModelProvider =
    NotifierProvider<TeamFeedViewModel, List<TeamFeed>>(
  () {
    return TeamFeedViewModel();
  },
);
