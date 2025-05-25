import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mercenaryhub/domain/entity/mercenary_feed.dart';
import 'package:mercenaryhub/domain/entity/mercenary_feed_log.dart';
import 'package:mercenaryhub/presentation/pages/providers.dart';

class MercenaryFeedViewModel extends Notifier<List<MercenaryFeed>> {
  @override
  build() {
    print('✅MercenaryFeedViewModel build');
    // streamFetchFeeds();
    // fetchFeeds();
    initialize();
    return [];
  }

  String? _lastId;
  bool _isLast = false;
  List<MercenaryFeedLog>? _feedLog;
  String? _location;

  void setLocationAndRefresh(String? location) {
    _location = location;
    _isLast = false;
    _lastId = null;

    state = [];
    fetchMercenaryFeeds();
  }

  void initialize() async {
    await fetchMercenaryFeedLogs(FirebaseAuth.instance.currentUser!.uid);
    fetchMercenaryFeeds();
  }

  void fetchMercenaryFeeds() async {
    print('✅FeedViewModel fetchFeeds');
    if (_isLast) return;

    final fetchMercenaryFeedsUsecase =
        ref.read(fetchMercenaryFeedsUsecaseProvider);
    final feedIds = _feedLog?.map((e) => e.feedId).toList() ?? [];

    print('😍');
    print('feedIds : $feedIds');
    print('😍');

    final nextFeeds = await fetchMercenaryFeedsUsecase.execute(
      lastId: _lastId,
      ignoreIds: feedIds,
      location: _location,
    );

    _isLast = nextFeeds.isEmpty;

    if (_isLast) return;
    _lastId = nextFeeds.last.id;

    state = [...state, ...nextFeeds];
    print('mer❌❌❌❌❌❌❌❌');
  }

  void streamFetchMercenaryFeeds() {
    print('✅MercenaryFeedViewModel streamFetchMercenaryFeeds');
    final streamFetchMercenaryFeedsUsecase =
        ref.read(streamFetchMercenaryFeedsUsecaseProvider);
    final streamFeedList = streamFetchMercenaryFeedsUsecase.execute();

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

  Future<void> fetchMercenaryFeedLogs(String uid) async {
    final fetchMercenaryFeedLogsUsecase =
        ref.read(fetchMercenaryFeedLogsUsecaseProvider);
    _feedLog = await fetchMercenaryFeedLogsUsecase.execute(uid);
  }

  Future<void> insertMercenaryFeedLog({
    required String uid,
    required String feedId,
    required bool isApplicant,
  }) async {
    final insertMercenaryFeedLogUsecase =
        ref.read(insertMercenaryFeedLogUsecaseProvider);

    _feedLog = [
      ..._feedLog ?? [],
      MercenaryFeedLog(
        uid: uid,
        feedId: feedId,
        isApplicant: isApplicant,
      ),
    ];

    await insertMercenaryFeedLogUsecase.execute(uid, feedId, isApplicant);

    // 신청(초대)으로 스와이프 했으면 'users/userId/mercenaryInvitationHistory'으로 데이터 보내기
    if (isApplicant) {
      final InviteToMercenaryUsecase =
          ref.read(inviteToMercenaryUsecaseProvider);

      InviteToMercenaryUsecase.execute(feedId);
    }
  }

  void removeFeedOfState() {
    state.removeAt(0);
    state = [...state];
  }
}

final mercenaryFeedViewModelProvider =
    NotifierProvider<MercenaryFeedViewModel, List<MercenaryFeed>>(
  () {
    return MercenaryFeedViewModel();
  },
);
