import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercenaryhub/domain/entity/team_feed_log.dart';
import 'package:mercenaryhub/presentation/pages/home/models/team_feed_state.dart';
import 'package:mercenaryhub/providers/feed_providers.dart';

class TeamFeedViewModel extends Notifier<TeamFeedState> {
  @override
  build() {
    initialize();
    return TeamFeedState(
      isLoading: true,
      isLast: false,
      feedList: [],
    );
  }

  String? _lastId;
  bool _isLast = false;
  List<TeamFeedLog>? _feedLog;
  String? _location;

  void setLocationAndRefresh(String? location) {
    _location = location;
    _isLast = false;
    _lastId = null;

    state = state.copyWith(
      feedList: [],
      isLast: false,
      isLoading: true,
    );
    fetchTeamFeeds();
  }

  void initialize({bool? isRefresh}) async {
    if (isRefresh ?? false) {
      _isLast = false;
      _lastId = null;
      state = state.copyWith(
        isLoading: true,
        isLast: false,
      );
    }
    await fetchTeamFeedLogs(FirebaseAuth.instance.currentUser!.uid);
    fetchTeamFeeds();
  }

  void fetchTeamFeeds() async {
    print('FeedViewModel fetchFeeds');
    // if (_isLast) return;

    final fetchTeamFeedsUsecase = ref.read(fetchTeamFeedsUsecaseProvider);
    final feedIds = _feedLog?.map((e) => e.feedId).toList() ?? [];
    final nextFeeds = await fetchTeamFeedsUsecase.execute(
      lastId: _lastId,
      ignoreIds: feedIds,
      location: _location,
    );

    _isLast = nextFeeds.isEmpty;

    if (_isLast) {
      state = state.copyWith(
        isLast: true,
        isLoading: false,
      );
      return;
    }

    _lastId = nextFeeds.last.id;
    state = state.copyWith(
      isLoading: false,
      isLast: false,
      feedList: [...state.feedList, ...nextFeeds],
    );
  }

  void streamFetchTeamFeeds() {
    print('FeedViewModel streamFetchFeeds');
    final streamFetchTeamFeedsUsecase =
        ref.read(streamFetchTeamFeedsUsecaseProvider);
    final streamFeedList = streamFetchTeamFeedsUsecase.execute();

    final streamSubscription = streamFeedList.listen((feeds) {
      state = state.copyWith(feedList: [...feeds]);
    });

    // 뷰모델이 메모리에서 소거될 때 onDispose의 callback이 호출 됨
    ref.onDispose(() {
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
      print('🔥 팀 신청 프로세스 시작 - feedId: $feedId');

      final applyToTeamUsecase = ref.read(applyToTeamUsecaseProvider);
      final success = await applyToTeamUsecase.execute(feedId);
    }
  }

  void removeFeedOfState() {
    state.feedList.removeAt(0);
    state = state.copyWith(feedList: [...state.feedList]);
  }
}

final teamFeedViewModelProvider =
    NotifierProvider<TeamFeedViewModel, TeamFeedState>(
  () {
    return TeamFeedViewModel();
  },
);
